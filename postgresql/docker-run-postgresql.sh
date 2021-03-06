#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

PASSWORD="${PASSWORD}"

######################################################################

function docker_run_postgresql11 {
    docker volume create postgresql11vol

    docker container run \
        --detach \
        --name postgresql11 \
        --publish 5432:5432 \
        --env POSTGRES_DB=postgres \
        --env POSTGRES_USER=postgres \
        --env POSTGRES_PASSWORD="${PASSWORD}" \
        --env PGDATA=/var/lib/postgresql/data/pgdata \
        --mount type=volume,src=postgresql11vol,dst=/var/lib/postgresql/data \
        postgres:11
}

function docker_run_postgresql12 {
    docker volume create postgresql12vol

    docker container run \
        --detach \
        --name postgresql12 \
        --publish 5432:5432 \
        --env POSTGRES_DB=postgres \
        --env POSTGRES_USER=postgres \
        --env POSTGRES_PASSWORD="${PASSWORD}" \
        --env PGDATA=/var/lib/postgresql/data/pgdata \
        --mount type=volume,src=postgresql12vol,dst=/var/lib/postgresql/data \
        postgres:12
}

function docker_run_postgresql13 {
    docker volume create postgresql13vol

    docker container run \
        --detach \
        --name postgresql13 \
        --publish 5432:5432 \
        --env POSTGRES_DB=postgres \
        --env POSTGRES_USER=postgres \
        --env POSTGRES_PASSWORD="${PASSWORD}" \
        --env PGDATA=/var/lib/postgresql/data/pgdata \
        --mount type=volume,src=postgresql13vol,dst=/var/lib/postgresql/data \
        postgres:13
}

######################################################################

# docker_run_postgresql11
# docker_run_postgresql12
docker_run_postgresql13
