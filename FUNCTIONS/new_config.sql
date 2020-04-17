CREATE FUNCTION New_Config(UnitType text, DocTypeCode text, BedType text, DocsPerBed numeric)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
INSERT INTO Configs (UnitTypeID, DocTypeID, BedTypeID, DocsPerBed) VALUES (UnitType(UnitType), DocType(DocTypeCode), BedType(BedType), DocsPerBed) RETURNING ConfigID
$$;
