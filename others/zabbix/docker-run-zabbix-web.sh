#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

PASSWORD="${PASSWORD}"

######################################################################

function docker_run_zabbix_web {
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
}
