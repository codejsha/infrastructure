#!/usr/bin/bash

docker run \
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
