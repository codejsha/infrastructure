#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

if [ ! -f "SHARED_SECRET.txt" ]; then
    echo "$(openssl rand -hex 16)" > SHARED_SECRET.txt
fi

DRONE_SERVER_HOST="drone.example.com"
DRONE_SERVER_PROTO="http"
SHARED_SECRET="$(cat SHARED_SECRET.txt)"

DRONE_VOLUME_DIR="/mnt/volume/drone"
sudo mkdir -p ${DRONE_VOLUME_DIR}

######################################################################

function docker_run_drone {
    docker container run \
        --detach \
        --name drone \
        --restart unless-stopped \
        --publish 80:80 \
        --publish 443:443 \
        --env DRONE_RPC_SECRET="${SHARED_SECRET}" \
        --env DRONE_SERVER_HOST="${DRONE_SERVER_HOST}" \
        --env DRONE_SERVER_PROTO="${DRONE_SERVER_PROTO}" \
        --mount type="bind",src="${DRONE_VOLUME_DIR}",dst="/data" \
        drone/drone:1

        ### github
        # --env DRONE_GITHUB_CLIENT_ID="" \
        # --env DRONE_GITHUB_CLIENT_SECRET="" \

        ### gitlab
        # --env DRONE_GITLAB_CLIENT_ID="" \
        # --env DRONE_GITLAB_CLIENT_SECRET="" \
        # --env DRONE_GITLAB_SERVER="" \
        # --env DRONE_GIT_ALWAYS_AUTH="" \

        ### logging
        # --env DRONE_LOGS_DEBUG=true \
        # --env DRONE_LOGS_TEXT=true \
        # --env DRONE_LOGS_PRETTY=true \
        # --env DRONE_LOGS_COLOR=true \
}

######################################################################

docker_run_drone
