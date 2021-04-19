#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

docker container run \
    --rm \
    --detach \
    --name mysql \
    --publish 3306:3306 \
    --env MYSQL_ROOT_PASSWORD="debezium" \
    --env MYSQL_USER="mysqluser" \
    --env MYSQL_PASSWORD="mysqlpw" \
    --env TZ="Asia/Seoul" \
    debezium/example-mysql:1.3

docker logs --follow mysql
