#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

PASSWORD="${PASSWORD}"

######################################################################

function docker_run_debezium_postgresql11 {
    local POSTGRES_VOLUME_DIR="/mnt/volume/postgresql"
    sudo mkdir -p ${POSTGRES_VOLUME_DIR}/data
    # docker run -i --rm debezium/postgres:11 cat /usr/share/postgresql/postgresql.conf.sample > debezium-postgresql.conf
    sudo /bin/cp -f debezium-postgresql.conf ${POSTGRES_VOLUME_DIR}/postgresql.conf

    docker container run \
        --detach \
        --name postgresql11 \
        --publish 5432:5432 \
        --env POSTGRES_DB="postgres" \
        --env POSTGRES_USER="postgres" \
        --env POSTGRES_PASSWORD="${PASSWORD}" \
        --env PGDATA="/var/lib/postgresql/data/pgdata" \
        --mount type="bind",src="${POSTGRES_VOLUME_DIR}/data",dst="/var/lib/postgresql/data" \
        --mount type="bind",src="${POSTGRES_VOLUME_DIR}/postgresql.conf",dst="/etc/postgresql/postgresql.conf" \
        --mount type="bind",src="/mnt/share",dst="/mnt/share" \
        --mount type="bind",src="/mnt/storage",dst="/mnt/storage" \
        debezium/postgres:11 \
        -c "config_file=/etc/postgresql/postgresql.conf"
}

function docker_run_debezium_postgresql12 {
    local POSTGRES_VOLUME_DIR="/mnt/volume/postgresql"
    sudo mkdir -p ${POSTGRES_VOLUME_DIR}/data
    # docker run -i --rm debezium/postgres:12 cat /usr/share/postgresql/postgresql.conf.sample > debezium-postgresql.conf
    sudo /bin/cp -f debezium-postgresql.conf ${POSTGRES_VOLUME_DIR}/postgresql.conf

    docker container run \
        --detach \
        --name postgresql12 \
        --publish 5432:5432 \
        --env POSTGRES_DB="postgres" \
        --env POSTGRES_USER="postgres" \
        --env POSTGRES_PASSWORD="${PASSWORD}" \
        --env PGDATA="/var/lib/postgresql/data/pgdata" \
        --mount type="bind",src="${POSTGRES_VOLUME_DIR}/data",dst="/var/lib/postgresql/data" \
        --mount type="bind",src="${POSTGRES_VOLUME_DIR}/postgresql.conf",dst="/etc/postgresql/postgresql.conf" \
        --mount type="bind",src="/mnt/share",dst="/mnt/share" \
        --mount type="bind",src="/mnt/storage",dst="/mnt/storage" \
        debezium/postgres:12 \
        -c "config_file=/etc/postgresql/postgresql.conf"
}

function docker_run_debezium_postgresql13 {
    local POSTGRES_VOLUME_DIR="/mnt/volume/postgresql"
    sudo mkdir -p ${POSTGRES_VOLUME_DIR}/data
    # docker run -i --rm debezium/postgres:13 cat /usr/share/postgresql/postgresql.conf.sample > debezium-postgresql.conf
    sudo /bin/cp -f debezium-postgresql.conf ${POSTGRES_VOLUME_DIR}/postgresql.conf

    docker container run \
        --detach \
        --name postgresql13 \
        --publish 5432:5432 \
        --env POSTGRES_DB="postgres" \
        --env POSTGRES_USER="postgres" \
        --env POSTGRES_PASSWORD="${PASSWORD}" \
        --env PGDATA="/var/lib/postgresql/data/pgdata" \
        --mount type="bind",src="${POSTGRES_VOLUME_DIR}/data",dst="/var/lib/postgresql/data" \
        --mount type="bind",src="/mnt/share",dst="/mnt/share" \
        --mount type="bind",src="/mnt/storage",dst="/mnt/storage" \
        --mount type="bind",src="${POSTGRES_VOLUME_DIR}/postgresql.conf",dst="/etc/postgresql/postgresql.conf" \
        debezium/postgres:13 \
        -c "config_file=/etc/postgresql/postgresql.conf"

}

######################################################################

# docker_run_debezium_postgresql11
# docker_run_debezium_postgresql12
docker_run_debezium_postgresql13
