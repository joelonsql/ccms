CREATE TABLE Hospitals (
HospitalID integer NOT NULL GENERATED ALWAYS AS IDENTITY,
HospitalCode text NOT NULL,
HospitalName text NOT NULL,
PRIMARY KEY (HospitalID),
UNIQUE (HospitalCode),
UNIQUE (HospitalName)
)