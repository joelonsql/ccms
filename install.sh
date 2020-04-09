#!/bin/sh
if [ -z "$DATABASE_NAME" ]; then
    DATABASE_NAME=ccms
fi
echo "Installing into database $DATABASE_NAME"
createuser ccms
if [ $DATABASE_NAME = "ccms" ]; then
    createdb ccms
fi
psql -X -f install.sql $DATABASE_NAME
psql -X -f test.sql $DATABASE_NAME
