CREATE TABLE Configs (
ConfigID integer NOT NULL GENERATED ALWAYS AS IDENTITY,
UnitTypeID integer NOT NULL REFERENCES UnitTypes,
DocTypeID integer NOT NULL REFERENCES DocTypes,
BedsPerDoc numeric NOT NULL,
PRIMARY KEY (ConfigID),
UNIQUE (UnitTypeID, DocTypeID),
CHECK (BedsPerDoc > 0)
);
