#!/bin/bash

PASSWORD="${PASSWORD}"

sudo mkdir -p /mnt/volume/zabbix-postgres-server

docker network create zabbix-network

docker container run \
    --detach \
    --name zabbix-postgres-server \
    --publish 5432:5432 \
    --net zabbix-network \
    --env POSTGRES_DB="zabbix" \
    --env POSTGRES_USER="zabbix" \
    --env POSTGRES_PASSWORD="${PASSWORD}" \
    --env PGDATA="/var/lib/postgresql/data/pgdata" \
    --mount type=bind,src="/mnt/volume/zabbix-postgres-server",dst="/var/lib/postgresql/data" \
    postgres:latest

docker container run \
    --detach \
    --name zabbix-server-pgsql \
    --net zabbix-network \
    --env DB_SERVER_HOST="zabbix-postgres-server" \
    --env DB_SERVER_PORT="5432" \
    --env POSTGRES_DB="zabbix" \
    --env POSTGRES_USER="zabbix" \
    --env POSTGRES_PASSWORD="${PASSWORD}" \
    zabbix/zabbix-server-pgsql:centos-latest

docker container run \
    --detach \
    --name zabbix-web-apache-pgsql \
    --publish 8081:8080 \
    --net zabbix-network \
    --env DB_SERVER_HOST="zabbix-postgres-server" \
    --env POSTGRES_USER="zabbix" \
    --env POSTGRES_PASSWORD="${PASSWORD}" \
    --env ZBX_SERVER_HOST="zabbix-server-pgsql" \
    --env PHP_TZ="Asia/Seoul" \
    zabbix/zabbix-web-apache-pgsql:centos-latest
