CREATE FUNCTION New_BedType(BedType text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
INSERT INTO BedTypes (BedType) VALUES (BedType) RETURNING BedTypeID
$$;
