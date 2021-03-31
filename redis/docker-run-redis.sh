#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

######################################################################

function docker_run_redis {
    docker container run \
        --detach \
        --name redis-server \
        --publish 6379:6379 \
        redis:latest
}

######################################################################

docker_run_redis
