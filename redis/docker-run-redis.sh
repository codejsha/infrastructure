#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

docker container run \
    --detach \
    --name redis-server \
    --publish 6379:6379 \
    redis:latest
