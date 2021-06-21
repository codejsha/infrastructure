#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

docker container run \
    --rm \
    --detach \
    --name kafka \
    --link zookeeper:zookeeper \
    --publish 9092:9092 \
    --env TZ="Asia/Seoul" \
    debezium/kafka:1.3

docker logs --follow kafka
