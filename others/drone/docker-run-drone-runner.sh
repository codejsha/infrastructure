#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

if [ ! -f "SHARED_SECRET.txt" ]; then
    echo "[ERROR] The SHARED_SECRET file does not exist!"
    exit
fi

DRONE_SERVER_HOST="drone.example.com"
DRONE_SERVER_PROTO="http"
SHARED_SECRET="$(cat SHARED_SECRET.txt)"

######################################################################

function docker_run_drone_runner {
    docker container run \
        --detach \
        --name runner \
        --restart unless-stopped \
        --publish 3000:3000 \
        --env DRONE_RPC_SKIP_VERIFY="true" \
        --env DRONE_RPC_PROTO="${DRONE_SERVER_PROTO}" \
        --env DRONE_RPC_HOST="${DRONE_SERVER_HOST}" \
        --env DRONE_RPC_SECRET="${SHARED_SECRET}" \
        --env DRONE_RUNNER_CAPACITY="2" \
        --env DRONE_RUNNER_NAME="${HOSTNAME}" \
        --env DRONE_UI_DISABLE="false" \
        --env DRONE_UI_USERNAME="admin" \
        --env DRONE_UI_PASSWORD="${PASSWORD}" \
        --mount type="bind",src="/var/run/docker.sock",dst="/var/run/docker.sock" \
        drone/drone-runner-docker:1

        ### logging
        # --env DRONE_DEBUG=true \
        # --env DRONE_TRACE=true \
        # --env DRONE_RPC_DUMP_HTTP=true \
        # --env DRONE_RPC_DUMP_HTTP_BODY=true \
}

######################################################################

docker_run_drone_runner
