#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

TEAMCITY_VOLUME_DIR="/mnt/volume/teamcity"
sudo mkdir -p ${TEAMCITY_VOLUME_DIR}

######################################################################

function docker_run_teamcity_server {
    docker container run \
        -it \
        --name teamcity-server-instance \
        --publish 8111:8111 \
        --mount type="bind",src="/mnt/volume/teamcity/datadir",dst="/data/teamcity_server/datadir" \
        --mount type="bind",src="/mnt/volume/teamcity/logs",dst="/opt/teamcity/logs" \
        jetbrains/teamcity-server
}

######################################################################

docker_run_teamcity_server
