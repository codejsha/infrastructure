#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

PASSWORD="${PASSWORD}"

POSTGRESQL_VOLUME_DIR="/mnt/volume/postgresql"
sudo mkdir -p ${POSTGRESQL_VOLUME_DIR}/data

######################################################################

function docker_run_postgresql13 {
    docker container run \
        --detach \
        --name postgresql13 \
        --publish 5432:5432 \
        --env POSTGRES_DB="postgres" \
        --env POSTGRES_USER="postgres" \
        --env POSTGRES_PASSWORD="${PASSWORD}" \
        --env PGDATA="/var/lib/postgresql/data/pgdata" \
        --mount type="bind",src="${POSTGRESQL_VOLUME_DIR}/data",dst="/var/lib/postgresql/data" \
        postgres:13
}

function docker_run_postgresql12 {
    docker container run \
        --detach \
        --name postgresql12 \
        --publish 5432:5432 \
        --env POSTGRES_DB="postgres" \
        --env POSTGRES_USER="postgres" \
        --env POSTGRES_PASSWORD="${PASSWORD}" \
        --env PGDATA="/var/lib/postgresql/data/pgdata" \
        --mount type="bind",src="${POSTGRESQL_VOLUME_DIR}/data",dst="/var/lib/postgresql/data" \
        postgres:12
}

function docker_run_postgresql11 {
    docker container run \
        --detach \
        --name postgresql11 \
        --publish 5432:5432 \
        --env POSTGRES_DB="postgres" \
        --env POSTGRES_USER="postgres" \
        --env POSTGRES_PASSWORD="${PASSWORD}" \
        --env PGDATA="/var/lib/postgresql/data/pgdata" \
        --mount type="bind",src="${POSTGRESQL_VOLUME_DIR}/data",dst="/var/lib/postgresql/data" \
        postgres:11
}

######################################################################

docker_run_postgresql13
# docker_run_postgresql12
# docker_run_postgresql11
