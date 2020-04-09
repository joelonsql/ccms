#!/bin/sh
if [ -z "$DATABASE_NAME" ]; then
    DATABASE_NAME=ccms
fi
psql -X -v ON_ERROR_STOP=1 -f uninstall.sql $DATABASE_NAME
if [ $DATABASE_NAME = "ccms" ]; then
    dropdb ccms
fi
dropuser ccms
