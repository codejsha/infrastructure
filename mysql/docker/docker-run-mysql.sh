#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

PASSWORD="${PASSWORD}"

MYSQL_VOLUME_DIR="/mnt/volume/mysql"
sudo mkdir -p ${MYSQL_VOLUME_DIR}/data

######################################################################

function docker_run_mysql8 {
    docker container run \
        --detach \
        --name mysql8 \
        --publish 3306:3306 \
        --publish 33060:33060 \
        --env MYSQL_ROOT_PASSWORD="${PASSWORD}" \
        --mount type="bind",src="${MYSQL_VOLUME_DIR}/data",dst="/var/lib/mysql" \
        mysql:8.0.23

        # --mount type="bind",src="${MYSQL_VOLUME_DIR}/config-file.cnf",dst="/etc/mysql/conf.d/config-file.cnf" \
}

function docker_run_mysql5 {
    docker container run \
        --detach \
        --name mysql5 \
        --publish 3306:3306 \
        --publish 33060:33060 \
        --env MYSQL_ROOT_PASSWORD="${PASSWORD}" \
        --mount type="bind",src="${MYSQL_VOLUME_DIR}/data",dst="/var/lib/mysql" \
        mysql:5.7.33

        # --mount type="bind",src="${MYSQL_VOLUME_DIR}/config-file.cnf",dst="/etc/mysql/conf.d/config-file.cnf" \
}

######################################################################

docker_run_mysql8
# docker_run_mysql5
