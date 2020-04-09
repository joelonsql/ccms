/*
The use of a schema allows ccms to co-exist together with other systems
in an existing database, by setting DATABASE_NAME to a different value.
*/
CREATE SCHEMA ccms;
ALTER SCHEMA ccms OWNER TO ccms;
REVOKE ALL ON SCHEMA ccms FROM PUBLIC;
GRANT ALL ON SCHEMA ccms TO ccms;

SET search_path TO ccms, public;

\ir TABLES/hospitals.sql
\ir FUNCTIONS/new_hospital.sql
\ir FUNCTIONS/hospital.sql

\ir TABLES/unittypes.sql
\ir FUNCTIONS/new_unittype.sql
\ir FUNCTIONS/unittype.sql

\ir TABLES/units.sql
\ir FUNCTIONS/new_unit.sql
\ir FUNCTIONS/unit.sql

\ir TABLES/resourcetypes.sql
\ir FUNCTIONS/new_resourcetype.sql
\ir FUNCTIONS/resourcetype.sql
