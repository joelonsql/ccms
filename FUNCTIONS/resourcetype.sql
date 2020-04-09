CREATE FUNCTION ResourceType(ResourceType text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
SELECT ResourceTypeID FROM ResourceTypes WHERE ResourceType = ResourceType
$$;
