CREATE FUNCTION New_UnitType(UnitType text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
INSERT INTO UnitTypes (UnitType) VALUES (UnitType) RETURNING UnitTypeID
$$;
