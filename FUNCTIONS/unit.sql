CREATE FUNCTION Unit(HospitalCode text, UnitCode text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
SELECT Units.UnitID FROM Units
INNER JOIN Hospitals ON Hospitals.HospitalID = Units.HospitalID
WHERE Hospitals.HospitalCode = Unit.HospitalCode
AND Units.UnitCode = Unit.UnitCode
$$;

CREATE FUNCTION Unit(UnitID integer)
RETURNS text
LANGUAGE sql
SET search_path TO ccms, public
AS $$
SELECT format('%s:%s', Hospitals.HospitalCode, Units.UnitCode) FROM Units
INNER JOIN Hospitals ON Hospitals.HospitalID = Units.HospitalID
WHERE Units.UnitID = Unit.UnitID
$$;
