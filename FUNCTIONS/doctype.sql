CREATE FUNCTION DocType(DocTypeCode text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
SELECT DocTypeID FROM DocTypes WHERE DocTypes.DocTypeCode = DocType.DocTypeCode
$$;
