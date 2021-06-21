#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace
# DVD Rental database (https://www.postgresqltutorial.com/postgresql-sample-database/)

PASSWORD="${PASSWORD}"

SAMPLE_DB_FILE_DIR="/mnt/share/postgresql"

### unzip archive file
unzip -d . ${SAMPLE_DB_FILE_DIR}/dvdrental.zip

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
