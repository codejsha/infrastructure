#!/bin/bash
# set -o errtrace
# set -o errexit
# trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

BURROW_VOLUME_DIR="/mnt/volume/burrow"
sudo mkdir -p ${BURROW_VOLUME_DIR}/{docker-config,tmp}
sudo /bin/cp -f burrow.toml ${BURROW_VOLUME_DIR}/docker-config/burrow.toml

BURROW_DOCKER_NETWORK="stream-network"
docker network create ${BURROW_DOCKER_NETWORK}

git clone https://github.com/linkedin/Burrow
# gh repo clone linkedin/Burrow

docker-compose up --detach
