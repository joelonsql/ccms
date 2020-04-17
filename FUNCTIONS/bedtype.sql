CREATE FUNCTION BedType(BedType text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
SELECT BedTypeID FROM BedTypes WHERE BedTypes.BedType = BedType.BedType
$$;

CREATE FUNCTION BedType(BedTypeID integer)
RETURNS text
LANGUAGE sql
SET search_path TO ccms, public
AS $$
SELECT BedType FROM BedTypes WHERE BedTypes.BedTypeID = BedType.BedTypeID
$$;
