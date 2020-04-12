\pset pager off

BEGIN;

SET search_path TO ccms, public;

SELECT New_Hospital(HospitalCode := 'H1', HospitalName := 'Hospital 1');
SELECT New_UnitType(UnitType := 'UT1');
SELECT New_Unit(UnitType := 'UT1', HospitalCode := 'H1', UnitCode := 'U1');
SELECT New_Unit(UnitType := 'UT1', HospitalCode := 'H1', UnitCode := 'U2');
SELECT New_Unit(UnitType := 'UT1', HospitalCode := 'H1', UnitCode := 'U3');
SELECT New_DocType(DocTypeCode := 'DT1', DocTypeName := 'DocType 1');
SELECT New_Doc(DocTypeCode := 'DT1', HospitalCode := 'H1', DocName := format('Doc %s',x)) FROM generate_series(1,10) AS x;
SELECT New_Bed(HospitalCode := 'H1', UnitCode := 'U1', BedCode := format('B%s',x)) FROM generate_series(1,10) AS x;
SELECT New_Bed(HospitalCode := 'H1', UnitCode := 'U2', BedCode := format('B%s',x)) FROM generate_series(1,20) AS x;
SELECT New_Bed(HospitalCode := 'H1', UnitCode := 'U3', BedCode := format('B%s',x)) FROM generate_series(1,30) AS x;

SELECT * FROM Hospitals;
SELECT * FROM UnitTypes;
SELECT * FROM Units;
SELECT * FROM DocTypes;
SELECT * FROM Docs;
SELECT * FROM Beds;

WITH
Demand AS (

    SELECT
        UnitID,
        COALESCE(LAG(ShareSum) OVER (ORDER BY UnitID),-1) AS FromRange,
        ShareSum AS ToRange
    FROM (
        SELECT
            UnitID,
            SUM(Share) OVER (ORDER BY UnitID) AS ShareSum
        FROM (
            SELECT
                UnitID,
                COUNT / SUM(COUNT) OVER () AS Share
            FROM (
                SELECT
                    UnitID,
                    COUNT(*)
                FROM Beds
                GROUP BY UnitID
            ) AS X
        ) AS Y
    ) AS Z

),
Supply AS (

    SELECT
        X.DocID,
        Demand.UnitID
    FROM (
        SELECT
            DocID,
            PERCENT_RANK() OVER (ORDER BY DocID)
        FROM Docs
    ) AS X
    INNER JOIN Demand ON X.PERCENT_RANK > Demand.FromRange AND X.PERCENT_RANK <= Demand.ToRange

)
UPDATE Docs SET UnitID = Supply.UnitID FROM Supply WHERE Supply.DocID = Docs.DocID;

SELECT UnitID, COUNT(*) FROM Beds GROUP BY UnitID ORDER BY UnitID;

SELECT UnitID, COUNT(*) FROM Docs GROUP BY UnitID ORDER BY UnitID;

COMMIT;
