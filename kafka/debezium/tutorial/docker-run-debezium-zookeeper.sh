#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

docker container run \
    --rm \
    --detach \
    --name zookeeper \
    --publish 2181:2181 \
    --publish 2888:2888 \
    --publish 3888:3888 \
    --env TZ="Asia/Seoul" \
    debezium/zookeeper:1.3

docker logs --follow zookeeper
