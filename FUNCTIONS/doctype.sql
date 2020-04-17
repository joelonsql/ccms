CREATE FUNCTION DocType(DocTypeCode text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
SELECT DocTypeID FROM DocTypes WHERE DocTypes.DocTypeCode = DocType.DocTypeCode
$$;

CREATE FUNCTION DocType(DocTypeID integer)
RETURNS text
LANGUAGE sql
SET search_path TO ccms, public
AS $$
SELECT DocTypeCode FROM DocTypes WHERE DocTypes.DocTypeID = DocType.DocTypeID
$$;
