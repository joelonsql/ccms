\pset pager off

BEGIN;

SET search_path TO ccms, public;


SELECT New_UnitType(UnitType := 'Trauma');
SELECT New_DocType(DocTypeCode := 'Läk', DocTypeName := 'Läkare');
SELECT New_DocType(DocTypeCode := 'Ssk', DocTypeName := 'Sjuksköterska');
SELECT New_DocType(DocTypeCode := 'Usk', DocTypeName := 'Undersköterska');
SELECT New_BedType(BedType := 'Vanlig');
SELECT New_BedType(BedType := 'Övervakning');
SELECT New_Config(UnitType := 'Trauma', DocTypeCode := 'Läk', BedType := 'Vanlig', DocsPerBed := 1/8.0);
SELECT New_Config(UnitType := 'Trauma', DocTypeCode := 'Ssk', BedType := 'Vanlig', DocsPerBed := 1/8.0);
SELECT New_Config(UnitType := 'Trauma', DocTypeCode := 'Usk', BedType := 'Vanlig', DocsPerBed := 1/8.0);
SELECT New_Config(UnitType := 'Trauma', DocTypeCode := 'Läk', BedType := 'Övervakning', DocsPerBed := 1/8.0);
SELECT New_Config(UnitType := 'Trauma', DocTypeCode := 'Ssk', BedType := 'Övervakning', DocsPerBed := 1/4.0);
SELECT New_Config(UnitType := 'Trauma', DocTypeCode := 'Usk', BedType := 'Övervakning', DocsPerBed := 1/2.0);

SELECT New_Hospital(HospitalCode := 'NKS', HospitalName := 'Nya Karolinska Sjukhuset');

SELECT New_Doc(DocTypeCode := 'Läk', HospitalCode := 'NKS', DocName := format('Läk %s',x), UnitType := 'Trauma') FROM generate_series(1,3) AS x;
SELECT New_Doc(DocTypeCode := 'Ssk', HospitalCode := 'NKS', DocName := format('Ssk %s',x), UnitType := 'Trauma') FROM generate_series(1,4) AS x;
SELECT New_Doc(DocTypeCode := 'Usk', HospitalCode := 'NKS', DocName := format('Usk %s',x), UnitType := 'Trauma') FROM generate_series(1,6) AS x;

SELECT New_Unit(UnitType := 'Trauma', HospitalCode := 'NKS', UnitCode := 'Trauma1');
SELECT New_Bed(HospitalCode := 'NKS', UnitCode := 'Trauma1', BedType := 'Vanlig', BedCode := format('Vanlig %s',x)) FROM generate_series(1,8) AS x;
SELECT New_Bed(HospitalCode := 'NKS', UnitCode := 'Trauma1', BedType := 'Övervakning', BedCode := format('Övervakning %s',x)) FROM generate_series(1,8) AS x;

SELECT New_Unit(UnitType := 'Trauma', HospitalCode := 'NKS', UnitCode := 'Trauma2');
SELECT New_Bed(HospitalCode := 'NKS', UnitCode := 'Trauma2', BedType := 'Vanlig', BedCode := format('Vanlig %s',x)) FROM generate_series(1,8) AS x;

/*

SELECT New_Doc(DocTypeCode := 'Läk', HospitalCode := 'NKS', DocName := format('Läk %s',x), UnitType := 'Trauma') FROM generate_series(1,2) AS x;
SELECT New_Doc(DocTypeCode := 'Ssk', HospitalCode := 'NKS', DocName := format('Ssk %s',x), UnitType := 'Trauma') FROM generate_series(1,3) AS x;
SELECT New_Doc(DocTypeCode := 'Usk', HospitalCode := 'NKS', DocName := format('Usk %s',x), UnitType := 'Trauma') FROM generate_series(1,5) AS x;
SELECT New_Bed(HospitalCode := 'NKS', UnitCode := 'Trauma', BedType := 'Vanlig', BedCode := format('Vanlig %s',x)) FROM generate_series(1,21) AS x;
SELECT New_Bed(HospitalCode := 'NKS', UnitCode := 'Trauma', BedType := 'Övervakning', BedCode := format('Övervakning %s',x)) FROM generate_series(1,4) AS x;


SELECT New_UnitType(UnitType := 'UT1');
SELECT New_UnitType(UnitType := 'UT2');
SELECT New_DocType(DocTypeCode := 'DT1', DocTypeName := 'DocType 1');
SELECT New_DocType(DocTypeCode := 'DT2', DocTypeName := 'DocType 2');
SELECT New_BedType(BedType := 'BT1');
SELECT New_Config(UnitType := 'UT1', DocTypeCode := 'DT1', BedType := 'BT1', DocsPerBed := 2);
SELECT New_Config(UnitType := 'UT1', DocTypeCode := 'DT2', BedType := 'BT1', DocsPerBed := 1);

SELECT New_Hospital(HospitalCode := 'H1', HospitalName := 'Hospital 1');
SELECT New_Unit(UnitType := 'UT1', HospitalCode := 'H1', UnitCode := 'U1');
SELECT New_Unit(UnitType := 'UT1', HospitalCode := 'H1', UnitCode := 'U2');
SELECT New_Unit(UnitType := 'UT1', HospitalCode := 'H1', UnitCode := 'U3');
SELECT New_Unit(UnitType := 'UT1', HospitalCode := 'H1', UnitCode := 'U4');
SELECT New_Doc(DocTypeCode := 'DT1', HospitalCode := 'H1', DocName := format('Doc1 %s',x), UnitType := 'UT1') FROM generate_series(1,12) AS x;
SELECT New_Doc(DocTypeCode := 'DT2', HospitalCode := 'H1', DocName := format('Doc2 %s',x), UnitType := 'UT1') FROM generate_series(1,100) AS x;
SELECT New_Bed(HospitalCode := 'H1', UnitCode := 'U1', BedType := 'BT1', BedCode := format('B%s',x)) FROM generate_series(1,10) AS x;
SELECT New_Bed(HospitalCode := 'H1', UnitCode := 'U2', BedType := 'BT1', BedCode := format('B%s',x)) FROM generate_series(1,20) AS x;
SELECT New_Bed(HospitalCode := 'H1', UnitCode := 'U3', BedType := 'BT1', BedCode := format('B%s',x)) FROM generate_series(1,30) AS x;
SELECT New_Bed(HospitalCode := 'H1', UnitCode := 'U4', BedType := 'BT1', BedCode := format('B%s',x)) FROM generate_series(1,10) AS x;

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
        DocTypeID,
        UnitID,
        COUNT,
        COALESCE(LAG(ShareSum) OVER (PARTITION BY HospitalID, UnitTypeID, DocTypeID ORDER BY UnitID),-0.000001) AS FromRange,
        ShareSum AS ToRange
    FROM (
        SELECT
            HospitalID,
            UnitTypeID,
            DocTypeID,
            UnitID,
            COUNT,
            SUM(Share) OVER (PARTITION BY HospitalID, UnitTypeID, DocTypeID ORDER BY UnitID) AS ShareSum
        FROM (
            SELECT
                HospitalID,
                UnitTypeID,
                DocTypeID,
                UnitID,
                SUM(NumDocs) OVER (PARTITION BY HospitalID, UnitTypeID, DocTypeID) AS COUNT,
                NumDocs / SUM(NumDocs) OVER (PARTITION BY HospitalID, UnitTypeID, DocTypeID) AS Share
            FROM (
                SELECT
                    Units.HospitalID,
                    Units.UnitTypeID,
                    Beds.UnitID,
                    Configs.DocTypeID,
                    SUM(Configs.DocsPerBed) AS NumDocs
                FROM Beds
                INNER JOIN Units ON Units.UnitID = Beds.UnitID
                INNER JOIN Configs ON Configs.BedTypeID = Beds.BedTypeID
                                  AND Configs.UnitTypeID = Units.UnitTypeID
                GROUP BY 1,2,3,4
            ) AS X
        ) AS Y
    ) AS Z

),
Supply AS (

    SELECT
        X.HospitalID,
        X.UnitTypeID,
        X.DocTypeID,
        X.DocID,
        X.PERCENT_RANK,
        Demand.UnitID
    FROM (
        SELECT
            Docs.HospitalID,
            Docs.UnitTypeID,
            Docs.DocTypeID,
            Docs.DocID,
            PERCENT_RANK() OVER (PARTITION BY Docs.HospitalID, Docs.UnitTypeID, Docs.DocTypeID ORDER BY Docs.DocID),
            COUNT(*) OVER (PARTITION BY Docs.HospitalID, Docs.UnitTypeID, Docs.DocTypeID)
        FROM Docs
    ) AS X
    INNER JOIN Demand ON Demand.HospitalID = X.HospitalID
                     AND Demand.UnitTypeID = X.UnitTypeID
                     AND Demand.DocTypeID  = X.DocTypeID
    INNER JOIN Configs ON Configs.UnitTypeID = X.UnitTypeID
                      AND Configs.DocTypeID = X.DocTypeID
    WHERE X.PERCENT_RANK >  (Demand.FromRange * LEAST(1,(Demand.Count / Configs.DocsPerBed) / X.COUNT))
    AND   X.PERCENT_RANK <= (Demand.ToRange   * LEAST(1,(Demand.Count / Configs.DocsPerBed) / X.COUNT))
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

CREATE VIEW Demand AS
SELECT
    HospitalID,
    UnitTypeID,
    UnitID,
    DocTypeID,
    Hospital(HospitalID),
    UnitType(UnitTypeID),
    Unit(UnitID),
    DocType(DocTypeID),
    NumDocs AS DesiredDocs,
    SUM(NumDocs) OVER (PARTITION BY HospitalID, UnitTypeID, DocTypeID),
    NumDocs / SUM(NumDocs) OVER (PARTITION BY HospitalID, UnitTypeID, DocTypeID) AS Share
FROM (
    SELECT
        Units.HospitalID,
        Units.UnitTypeID,
        Beds.UnitID,
        Configs.DocTypeID,
        SUM(Configs.DocsPerBed) AS NumDocs
    FROM Beds
    INNER JOIN Units ON Units.UnitID = Beds.UnitID
    INNER JOIN Configs ON Configs.BedTypeID = Beds.BedTypeID
                        AND Configs.UnitTypeID = Units.UnitTypeID
    GROUP BY 1,2,3,4
) AS X
ORDER BY 1,2,3,4;

CREATE VIEW Supply AS
SELECT
    Docs.HospitalID,
    Docs.UnitTypeID,
    Docs.DocTypeID,
    Hospital(Docs.HospitalID),
    UnitType(Docs.UnitTypeID),
    DocType(Docs.DocTypeID),
    COUNT(*) AS AvailableDocs
FROM Docs
INNER JOIN Hospitals ON Hospitals.HospitalID = Docs.HospitalID
INNER JOIN UnitTypes ON UnitTypes.UnitTypeID = Docs.UnitTypeID
INNER JOIN DocTypes ON DocTypes.DocTypeID = Docs.DocTypeID
GROUP BY 1,2,3
ORDER BY 1,2,3;

CREATE VIEW Matched AS
SELECT
    Demand.Hospital,
    Demand.UnitType,
    Demand.DocType,
    Demand.Unit,
    ROUND(LEAST(Supply.AvailableDocs * Demand.Share, Demand.DesiredDocs)) AS AllocatedDocs
FROM Demand
INNER JOIN Supply ON Supply.HospitalID = Demand.HospitalID
                 AND Supply.UnitTypeID = Demand.UnitTypeID
                 AND Supply.DocTypeID  = Demand.DocTypeID
ORDER BY 1,2,3,4
;

SELECT Hospital, UnitType, Unit, DocType, ROUND(DesiredDocs) AS DesiredDocs FROM Demand;
SELECT Hospital, UnitType, DocType, ROUND(AvailableDocs) AS AvailableDocs FROM Supply;
SELECT Hospital, UnitType, DocType, Unit, AllocatedDocs FROM Matched;

COMMIT;
