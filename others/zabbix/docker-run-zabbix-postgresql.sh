#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

PASSWORD="${PASSWORD}"

ZABBIX_POSTGRESQL_VOLUME_DIR="/mnt/volume/zabbix-postgres"
sudo mkdir -p ${ZABBIX_POSTGRESQL_VOLUME_DIR}

######################################################################

function docker_run_zabbix_postgresql {
    docker container run \
        --detach \
        --name zabbix-postgres-server \
        --net zabbix-network \
        --publish 5432:5432 \
        --env POSTGRES_DB="zabbix" \
        --env POSTGRES_USER="zabbix" \
        --env POSTGRES_PASSWORD="${PASSWORD}" \
        --env PGDATA="/var/lib/postgresql/data/pgdata" \
        --mount type=bind,src="${ZABBIX_POSTGRESQL_VOLUME_DIR}",dst="/var/lib/postgresql/data" \
        postgres:latest
}

######################################################################

docker_run_zabbix_postgresql

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
    --net zabbix-network \
    --publish 8081:8080 \
    --env DB_SERVER_HOST="zabbix-postgres-server" \
    --env POSTGRES_USER="zabbix" \
    --env POSTGRES_PASSWORD="${PASSWORD}" \
    --env ZBX_SERVER_HOST="zabbix-server-pgsql" \
    --env PHP_TZ="Asia/Seoul" \
    zabbix/zabbix-web-apache-pgsql:centos-latest
