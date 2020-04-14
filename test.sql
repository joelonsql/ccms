\pset pager off

BEGIN;

SET search_path TO ccms, public;

SELECT New_UnitType(UnitType := 'UT1');
SELECT New_UnitType(UnitType := 'UT2');
SELECT New_DocType(DocTypeCode := 'DT1', DocTypeName := 'DocType 1');
SELECT New_DocType(DocTypeCode := 'DT2', DocTypeName := 'DocType 2');
SELECT New_Config(UnitType := 'UT1', DocTypeCode := 'DT1', BedsPerDoc := 2);
SELECT New_Config(UnitType := 'UT1', DocTypeCode := 'DT2', BedsPerDoc := 1);

SELECT New_Hospital(HospitalCode := 'H1', HospitalName := 'Hospital 1');
SELECT New_Unit(UnitType := 'UT1', HospitalCode := 'H1', UnitCode := 'U1');
SELECT New_Unit(UnitType := 'UT1', HospitalCode := 'H1', UnitCode := 'U2');
SELECT New_Unit(UnitType := 'UT1', HospitalCode := 'H1', UnitCode := 'U3');
SELECT New_Unit(UnitType := 'UT1', HospitalCode := 'H1', UnitCode := 'U4');
SELECT New_Doc(DocTypeCode := 'DT1', HospitalCode := 'H1', DocName := format('Doc1 %s',x), UnitType := 'UT1') FROM generate_series(1,12) AS x;
SELECT New_Doc(DocTypeCode := 'DT2', HospitalCode := 'H1', DocName := format('Doc2 %s',x), UnitType := 'UT1') FROM generate_series(1,100) AS x;
SELECT New_Bed(HospitalCode := 'H1', UnitCode := 'U1', BedCode := format('B%s',x)) FROM generate_series(1,10) AS x;
SELECT New_Bed(HospitalCode := 'H1', UnitCode := 'U2', BedCode := format('B%s',x)) FROM generate_series(1,20) AS x;
SELECT New_Bed(HospitalCode := 'H1', UnitCode := 'U3', BedCode := format('B%s',x)) FROM generate_series(1,30) AS x;
SELECT New_Bed(HospitalCode := 'H1', UnitCode := 'U4', BedCode := format('B%s',x)) FROM generate_series(1,10) AS x;

/*

SELECT New_Hospital(HospitalCode := 'H2', HospitalName := 'Hospital 2');
SELECT New_Unit(UnitType := 'UT1', HospitalCode := 'H2', UnitCode := 'U1');
SELECT New_Unit(UnitType := 'UT1', HospitalCode := 'H2', UnitCode := 'U2');
SELECT New_Doc(DocTypeCode := 'DT1', HospitalCode := 'H2', DocName := format('Doc %s',x), UnitType := 'UT1') FROM generate_series(1,10) AS x;
SELECT New_Bed(HospitalCode := 'H2', UnitCode := 'U1', BedCode := format('B%s',x)) FROM generate_series(1,35) AS x;
SELECT New_Bed(HospitalCode := 'H2', UnitCode := 'U2', BedCode := format('B%s',x)) FROM generate_series(1,65) AS x;

SELECT New_Hospital(HospitalCode := 'H3', HospitalName := 'Hospital 3');
SELECT New_Unit(UnitType := 'UT1', HospitalCode := 'H3', UnitCode := 'U1');
SELECT New_Unit(UnitType := 'UT1', HospitalCode := 'H3', UnitCode := 'U2');
SELECT New_Unit(UnitType := 'UT2', HospitalCode := 'H3', UnitCode := 'U3');
SELECT New_Unit(UnitType := 'UT2', HospitalCode := 'H3', UnitCode := 'U4');
SELECT New_Doc(DocTypeCode := 'DT1', HospitalCode := 'H3', DocName := format('Doc1 %s',x), UnitType := 'UT1') FROM generate_series(1,15) AS x;
SELECT New_Doc(DocTypeCode := 'DT1', HospitalCode := 'H3', DocName := format('Doc2 %s',x), UnitType := 'UT2') FROM generate_series(1,30) AS x;
SELECT New_Bed(HospitalCode := 'H3', UnitCode := 'U1', BedCode := format('B%s',x)) FROM generate_series(1,5) AS x;
SELECT New_Bed(HospitalCode := 'H3', UnitCode := 'U2', BedCode := format('B%s',x)) FROM generate_series(1,10) AS x;
SELECT New_Bed(HospitalCode := 'H3', UnitCode := 'U3', BedCode := format('B%s',x)) FROM generate_series(1,10) AS x;
SELECT New_Bed(HospitalCode := 'H3', UnitCode := 'U4', BedCode := format('B%s',x)) FROM generate_series(1,20) AS x;

SELECT New_Hospital(HospitalCode := 'H4', HospitalName := 'Hospital 4');
SELECT New_Unit(UnitType := 'UT1', HospitalCode := 'H4', UnitCode := 'U1');
SELECT New_Unit(UnitType := 'UT1', HospitalCode := 'H4', UnitCode := 'U2');
SELECT New_Doc(DocTypeCode := 'DT1', HospitalCode := 'H4', DocName := format('Doc1 %s',x), UnitType := 'UT1') FROM generate_series(1,10) AS x;
SELECT New_Doc(DocTypeCode := 'DT2', HospitalCode := 'H4', DocName := format('Doc2 %s',x), UnitType := 'UT1') FROM generate_series(1,20) AS x;
SELECT New_Bed(HospitalCode := 'H4', UnitCode := 'U1', BedCode := format('B%s',x)) FROM generate_series(1,10) AS x;
SELECT New_Bed(HospitalCode := 'H4', UnitCode := 'U2', BedCode := format('B%s',x)) FROM generate_series(1,5) AS x;

*/

WITH
Demand AS (

    SELECT
        HospitalID,
        UnitTypeID,
        UnitID,
        COUNT,
        COALESCE(LAG(ShareSum) OVER (PARTITION BY HospitalID, UnitTypeID ORDER BY UnitID),-0.000001) AS FromRange,
        ShareSum AS ToRange
    FROM (
        SELECT
            HospitalID,
            UnitTypeID,
            UnitID,
            COUNT,
            SUM(Share) OVER (PARTITION BY HospitalID, UnitTypeID ORDER BY UnitID) AS ShareSum
        FROM (
            SELECT
                HospitalID,
                UnitTypeID,
                UnitID,
                SUM(COUNT) OVER (PARTITION BY HospitalID, UnitTypeID) AS COUNT,
                COUNT / SUM(COUNT) OVER (PARTITION BY HospitalID, UnitTypeID) AS Share
            FROM (
                SELECT
                    Units.HospitalID,
                    Units.UnitTypeID,
                    Beds.UnitID,
                    COUNT(*)
                FROM Beds
                INNER JOIN Units ON Units.UnitID = Beds.UnitID
                GROUP BY 1,2,3
            ) AS X
        ) AS Y
    ) AS Z

),
Supply AS (

    SELECT
        X.HospitalID,
        X.UnitTypeID,
        X.DocID,
        X.PERCENT_RANK,
        Demand.UnitID
    FROM (
        SELECT
            Docs.HospitalID,
            Docs.UnitTypeID,
            Docs.DocTypeID,
            Docs.DocID,
            PERCENT_RANK() OVER (PARTITION BY Docs.HospitalID, Docs.DocTypeID, Docs.UnitTypeID ORDER BY Docs.DocID),
            COUNT(*) OVER (PARTITION BY Docs.HospitalID, Docs.DocTypeID, Docs.UnitTypeID)
        FROM Docs
    ) AS X
    INNER JOIN Demand ON Demand.HospitalID = X.HospitalID
                     AND Demand.UnitTypeID = X.UnitTypeID
    INNER JOIN Configs ON Configs.UnitTypeID = X.UnitTypeID
                      AND Configs.DocTypeID = X.DocTypeID
    WHERE X.PERCENT_RANK >  (Demand.FromRange * LEAST(1,(Demand.Count / Configs.BedsPerDoc) / X.COUNT))
    AND   X.PERCENT_RANK <= (Demand.ToRange   * LEAST(1,(Demand.Count / Configs.BedsPerDoc) / X.COUNT))
)
UPDATE Docs SET UnitID = Supply.UnitID FROM Supply WHERE Supply.DocID = Docs.DocID;

SELECT * FROM Hospitals;
SELECT * FROM UnitTypes;
SELECT * FROM Units;
SELECT * FROM DocTypes;
SELECT * FROM Docs;
SELECT * FROM Beds;

SELECT
    Hospitals.HospitalName,
    UnitTypes.UnitType,
    Units.UnitCode,
    COUNT(*) AS Beds
FROM Beds
INNER JOIN Units ON Units.UnitID = Beds.UnitID
INNER JOIN UnitTypes ON UnitTypes.UnitTypeID = Units.UnitTypeID
INNER JOIN Hospitals ON Hospitals.HospitalID = Units.HospitalID
GROUP BY 1,2,3
ORDER BY 1,2,3;

SELECT
    Hospitals.HospitalName,
    UnitTypes.UnitType,
    DocTypes.DocTypeName,
    Units.UnitCode,
    COUNT(*) AS Docs
FROM Docs
INNER JOIN UnitTypes ON UnitTypes.UnitTypeID = Docs.UnitTypeID
INNER JOIN DocTypes ON DocTypes.DocTypeID = Docs.DocTypeID
INNER JOIN Hospitals ON Hospitals.HospitalID = Docs.HospitalID
LEFT JOIN Units ON Units.UnitID = Docs.UnitID
GROUP BY 1,2,3,4
ORDER BY 1,2,3,4;

SELECT HospitalID, DocTypeID, UnitID, COUNT(*) FROM Docs GROUP BY HospitalID, DocTypeID, UnitID ORDER BY HospitalID, DocTypeID, UnitID;

SELECT * FROM Configs;

COMMIT;
