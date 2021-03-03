#!/bin/bash

PASSWORD="${PASSWORD}"

PGPASSWORD="${PASSWORD}" psql --host=test.example.com --port=5432 --username=postgres --file=postgresql-connector-requirements.sql
