CREATE FUNCTION New_ResourceType(ResourceType text, ResourceName text)
RETURNS integer
LANGUAGE sql
SET search_path TO ccms, public
AS $$
INSERT INTO ResourceTypes (ResourceType, ResourceName) VALUES (ResourceType, ResourceName) RETURNING ResourceTypeID
$$;
