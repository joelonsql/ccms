CREATE FUNCTION UnitType(UnitType text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
SELECT UnitTypeID FROM UnitTypes WHERE UnitTypes.UnitType = UnitType.UnitType
$$;

CREATE FUNCTION UnitType(UnitTypeID integer)
RETURNS text
LANGUAGE sql
SET search_path TO ccms, public
AS $$
SELECT UnitType FROM UnitTypes WHERE UnitTypes.UnitTypeID = UnitType.UnitTypeID
$$;
