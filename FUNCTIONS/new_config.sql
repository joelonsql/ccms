CREATE FUNCTION New_Config(UnitType text, DocTypeCode text, BedsPerDoc integer)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
INSERT INTO Configs (UnitTypeID, DocTypeID, BedsPerDoc) VALUES (UnitType(UnitType), DocType(DocTypeCode), BedsPerDoc) RETURNING ConfigID
$$;
