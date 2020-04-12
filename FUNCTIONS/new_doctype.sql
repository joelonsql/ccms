CREATE FUNCTION New_DocType(DocTypeCode text, DocTypeName text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
INSERT INTO DocTypes (DocTypeCode, DocTypeName) VALUES (DocTypeCode, DocTypeName) RETURNING DocTypeID
$$;
