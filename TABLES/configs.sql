CREATE TABLE Configs (
ConfigID integer NOT NULL GENERATED ALWAYS AS IDENTITY,
UnitTypeID integer NOT NULL REFERENCES UnitTypes,
DocTypeID integer NOT NULL REFERENCES DocTypes,
BedTypeID integer NOT NULL REFERENCES BedTypes,
DocsPerBed numeric NOT NULL,
PRIMARY KEY (ConfigID),
UNIQUE (UnitTypeID, DocTypeID, BedTypeID),
CHECK (DocsPerBed > 0)
);
