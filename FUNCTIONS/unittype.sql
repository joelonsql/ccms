CREATE FUNCTION UnitType(UnitType text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
SELECT UnitTypeID FROM UnitTypes WHERE UnitTypes.UnitType = UnitType.UnitType
$$;
