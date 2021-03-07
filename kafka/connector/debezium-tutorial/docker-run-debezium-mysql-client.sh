#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

MYSQL_PORT_3306_TCP_ADDR="mysql"
MYSQL_PORT_3306_TCP_PORT="3306"
MYSQL_ENV_MYSQL_ROOT_PASSWORD="debezium"

docker container run \
    --detach \
    --rm \
    --name mysqlterm \
    --link mysql:mysql \
    --env TZ="Asia/Seoul" \
    mysql:5.7 \
    mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"

docker logs --follow mysqlterm
