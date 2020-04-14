CREATE FUNCTION Doc(HospitalCode text, DocName text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
SELECT DocID FROM Docs WHERE HospitalID = Hospital(Doc.HospitalCode) AND Docs.DocName = Doc.DocName
$$;
