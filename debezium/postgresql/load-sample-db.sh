#!/bin/bash
# DVD Rental database (https://www.postgresqltutorial.com/postgresql-sample-database/)

PASSWORD="${PASSWORD}"

SAMPLE_DB_FILE_DIR="/mnt/share/postgresql"

/usr/bin/cp -pf ${SAMPLE_DB_FILE_DIR}/dvdrental.zip .
unzip dvdrental.zip

PGPASSWORD="${PASSWORD}" psql --host=test.example.com --port=5432 --username=postgres --command="CREATE DATABASE dvdrental"
PGPASSWORD="${PASSWORD}" pg_restore --host=test.example.com --port=5432 --username=postgres --dbname=dvdrental ./dvdrental.tar
