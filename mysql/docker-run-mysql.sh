#!/bin/bash

PASSWORD="${PASSWORD}"

function docker_run_mysql8 {
    docker run \
        --detach \
        --name mysql8 \
        --publish 3306:3306 \
        --env MYSQL_ROOT_PASSWORD="${PASSWORD}" \
        --env PGDATA=/var/lib/postgresql/data/pgdata \
        --mount type=bind,src=/mnt/volume/mysql,dst=/var/lib/mysql \
        mysql:8.0.21
}

function docker_run_mysql5 {
    docker run \
        --detach \
        --name mysql5 \
        --publish 3306:3306 \
        --env MYSQL_ROOT_PASSWORD="${PASSWORD}" \
        --env PGDATA=/var/lib/postgresql/data/pgdata \
        --mount type=bind,src=/mnt/volume/mysql,dst=/var/lib/mysql \
        mysql:5.7.31
}

######################################################################

docker_run_mysql8
# docker_run_mysql5
