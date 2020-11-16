#!/usr/bin/bash

if [ ! -f SHARED_SECRET.txt ]; then
    echo "$(openssl rand -hex 16)" > SHARED_SECRET.txt
fi

SHARED_SECRET="$(cat SHARED_SECRET.txt)"

######################################################################

### docker server

docker pull drone/drone:1

DRONE_SERVER_HOST="drone.example.com"
DRONE_SERVER_PROTO="http"

docker run \
    --detach \
    --name drone \
    --restart unless-stopped \
    --publish 80:80 \
    --publish 443:443 \
    --env DRONE_RPC_SECRET="${SHARED_SECRET}" \
    --env DRONE_SERVER_HOST="${DRONE_SERVER_HOST}" \
    --env DRONE_SERVER_PROTO="${DRONE_SERVER_PROTO}" \
    --mount type=bind,src=/mnt/volume/drone,dst=/data \
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

######################################################################

### docker runner

docker pull drone/drone-runner-docker:1

docker run -d \
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
    -v /var/run/docker.sock:/var/run/docker.sock \
    drone/drone-runner-docker:1

    ### logging
    # --env DRONE_DEBUG=true \
    # --env DRONE_TRACE=true \
    # --env DRONE_RPC_DUMP_HTTP=true \
    # --env DRONE_RPC_DUMP_HTTP_BODY=true \
