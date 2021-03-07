#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

docker container run \
    --detach \
    --rm \
    --name kafka \
    --link zookeeper:zookeeper \
    --publish 9092:9092 \
    --env TZ="Asia/Seoul" \
    debezium/kafka:1.3

docker logs --follow kafka
