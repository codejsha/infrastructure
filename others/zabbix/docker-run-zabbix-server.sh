#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

PASSWORD="${PASSWORD}"

######################################################################

function docker_run_zabbix_server {
    docker container run \
        --detach \
        --name zabbix-server-pgsql \
        --network zabbix-network \
        --env DB_SERVER_HOST="zabbix-postgres-server" \
        --env DB_SERVER_PORT="5432" \
        --env POSTGRES_DB="zabbix" \
        --env POSTGRES_USER="zabbix" \
        --env POSTGRES_PASSWORD="${PASSWORD}" \
        zabbix/zabbix-server-pgsql:centos-latest
}

######################################################################

docker_run_zabbix_server
