CREATE FUNCTION New_Unit(UnitType text, HospitalCode text, UnitCode text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
INSERT INTO Units (UnitTypeID, HospitalID, UnitCode) VALUES (UnitType(UnitType), Hospital(HospitalCode), UnitCode) RETURNING UnitID
$$;
