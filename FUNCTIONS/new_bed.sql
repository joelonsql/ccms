CREATE FUNCTION New_Bed(HospitalCode text, UnitCode text, BedCode text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
INSERT INTO Beds (UnitID, BedCode) VALUES (Unit(HospitalCode,UnitCode), BedCode) RETURNING BedID
$$;
