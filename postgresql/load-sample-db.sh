#!/bin/bash
# DVD Rental database (https://www.postgresqltutorial.com/postgresql-sample-database/)

PASSWORD="${PASSWORD}"

SAMPLE_DB_FILE_DIR="/mnt/share/postgresql"

### unzip archive file
/usr/bin/cp -pf ${SAMPLE_DB_FILE_DIR}/dvdrental.zip .
unzip dvdrental.zip

### create database
PGPASSWORD="${PASSWORD}" \
    psql \
    --host=postgres-lb.example.com \
    --port=5432 \
    --username=postgres \
    --command="CREATE DATABASE dvdrental"

### load database
PGPASSWORD="${PASSWORD}" \
    pg_restore \
    --host=postgres-lb.example.com \
    --port=5432 \
    --username=postgres \
    --dbname=dvdrental \
    ./dvdrental.tar
