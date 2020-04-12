CREATE TABLE DocTypes (
DocTypeID integer NOT NULL GENERATED ALWAYS AS IDENTITY,
DocTypeCode text NOT NULL,
DocTypeName text NOT NULL,
PRIMARY KEY (DocTypeID),
UNIQUE (DocTypeCode),
UNIQUE (DocTypeName)
);
