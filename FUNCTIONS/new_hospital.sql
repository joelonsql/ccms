CREATE FUNCTION New_Hospital(HospitalCode text, HospitalName text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
INSERT INTO Hospitals (HospitalCode, HospitalName) VALUES (HospitalCode, HospitalName) RETURNING HospitalID
$$;
