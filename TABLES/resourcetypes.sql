CREATE TABLE ResourceTypes (
ResourceTypeID integer NOT NULL GENERATED ALWAYS AS IDENTITY,
ResourceType text NOT NULL,
ResourceName text NOT NULL,
PRIMARY KEY (ResourceTypeID),
UNIQUE (ResourceType),
UNIQUE (ResourceName)
);
