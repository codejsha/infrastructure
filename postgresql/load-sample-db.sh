#!/bin/bash

PASSWORD="${PASSWORD}"

SAMPLE_DB_FILE_DIR="/mnt/share/postgresql"

PGPASSWORD="${PASSWORD}" \
    psql \
    --host=postgres-lb.example.com \
    --port=5432 \
    --username=postgres \
    --command="CREATE DATABASE dvdrental"
PGPASSWORD="${PASSWORD}" \
    psql \
    --host=postgres-lb.example.com \
    --port=5432 \
    --username=postgres \
    --dbname=dvdrental \
    --command="\l"
###                                   List of databases
###    Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
### -----------+----------+----------+-------------+-------------+-----------------------
###  dvdrental | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
###  postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
###  template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
###            |          |          |             |             | postgres=CTc/postgres
###  template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
###            |          |          |             |             | postgres=CTc/postgres
### (4 rows)

/usr/bin/cp -pf ${SAMPLE_DB_FILE_DIR}/dvdrental.zip .
unzip dvdrental.zip
PGPASSWORD="${PASSWORD}" \
    pg_restore \
    --host=postgres-lb.example.com \
    --port=5432 \
    --username=postgres \
    --dbname=dvdrental \
    ./dvdrental.tar
PGPASSWORD="${PASSWORD}" \
    psql \
    --host=postgres-lb.example.com \
    --port=5432 \
    --username=postgres \
    --dbname=dvdrental \
    --command="\dt"
###              List of relations
###  Schema |     Name      | Type  |  Owner
### --------+---------------+-------+----------
###  public | actor         | table | postgres
###  public | address       | table | postgres
###  public | category      | table | postgres
###  public | city          | table | postgres
###  public | country       | table | postgres
###  public | customer      | table | postgres
###  public | film          | table | postgres
###  public | film_actor    | table | postgres
###  public | film_category | table | postgres
###  public | inventory     | table | postgres
###  public | language      | table | postgres
###  public | payment       | table | postgres
###  public | rental        | table | postgres
###  public | staff         | table | postgres
###  public | store         | table | postgres
### (15 rows)
