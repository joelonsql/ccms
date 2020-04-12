CREATE FUNCTION New_Doc(DocTypeCode text, HospitalCode text, DocName text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
INSERT INTO Docs (DocTypeID, HospitalID, DocName) VALUES (DocType(DocTypeCode), Hospital(HospitalCode), DocName) RETURNING DocID
$$;
