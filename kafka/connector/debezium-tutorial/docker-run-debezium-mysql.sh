#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

docker container run \
    --detach \
    --rm \
    --name mysql \
    --publish 3306:3306 \
    --env MYSQL_ROOT_PASSWORD="debezium" \
    --env MYSQL_USER="mysqluser" \
    --env MYSQL_PASSWORD="mysqlpw" \
    --env TZ="Asia/Seoul" \
    debezium/example-mysql:1.3

docker logs --follow mysql
