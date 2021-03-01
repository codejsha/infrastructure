#!/bin/bash

PASSWORD="${PASSWORD}"

MYSQL_VOLUME_DIR="/mnt/volume/mysql"
sudo mkdir -p ${MYSQL_VOLUME_DIR}

######################################################################

function docker_run_mysql8 {
    docker container run \
        --detach \
        --name mysql8 \
        --publish 3306:3306 \
        --publish 33060:33060 \
        --env MYSQL_ROOT_PASSWORD="${PASSWORD}" \
        --env PGDATA=/var/lib/postgresql/data/pgdata \
        --mount type=bind,src=${MYSQL_VOLUME_DIR},dst=/var/lib/mysql \
        --mount type=bind,src=/mnt/share,dst=/mnt/share \
        --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
        mysql:8.0.23
}

function docker_run_mysql5 {
    docker container run \
        --detach \
        --name mysql5 \
        --publish 3306:3306 \
        --publish 33060:33060 \
        --env MYSQL_ROOT_PASSWORD="${PASSWORD}" \
        --env PGDATA=/var/lib/postgresql/data/pgdata \
        --mount type=bind,src=${MYSQL_VOLUME_DIR},dst=/var/lib/mysql \
        --mount type=bind,src=/mnt/share,dst=/mnt/share \
        --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
        mysql:5.7.33
}

######################################################################

docker_run_mysql8
# docker_run_mysql5
