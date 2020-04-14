CREATE TABLE Docs (
DocID integer NOT NULL GENERATED ALWAYS AS IDENTITY,
DocTypeID integer NOT NULL REFERENCES DocTypes,
DocName text NOT NULL,
HospitalID integer NOT NULL REFERENCES Hospitals,
UnitTypeID integer NOT NULL REFERENCES UnitTypes,
UnitID integer REFERENCES Units,
PRIMARY KEY (DocID),
UNIQUE (HospitalID, DocName)
);
