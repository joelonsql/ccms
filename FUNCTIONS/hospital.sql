CREATE FUNCTION Hospital(HospitalCode text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
SELECT HospitalID FROM Hospitals WHERE HospitalCode = HospitalCode
$$;
