CREATE FUNCTION Hospital(HospitalCode text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
SELECT HospitalID FROM Hospitals WHERE Hospitals.HospitalCode = Hospital.HospitalCode
$$;

CREATE FUNCTION Hospital(HospitalID integer)
RETURNS text
LANGUAGE sql
SET search_path TO ccms, public
AS $$
SELECT HospitalCode FROM Hospitals WHERE Hospitals.HospitalID = Hospital.HospitalID
$$;
