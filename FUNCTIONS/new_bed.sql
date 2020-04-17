CREATE FUNCTION New_Bed(BedType text, HospitalCode text, UnitCode text, BedCode text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
INSERT INTO Beds (BedTypeID, UnitID, BedCode) VALUES (BedType(BedType), Unit(HospitalCode,UnitCode), BedCode) RETURNING BedID
$$;
