CREATE TABLE Units (
UnitID integer NOT NULL GENERATED ALWAYS AS IDENTITY,
UnitTypeID integer NOT NULL REFERENCES UnitTypes,
HospitalID integer NOT NULL REFERENCES Hospitals,
UnitCode text NOT NULL,
PRIMARY KEY (UnitID),
UNIQUE (HospitalID, UnitCode)
);
