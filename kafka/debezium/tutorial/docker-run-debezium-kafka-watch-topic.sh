#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

docker container run \
    --rm \
    --detach \
    --name watcher \
    --link zookeeper:zookeeper \
    --link kafka:kafka \
    --env TZ="Asia/Seoul" \
    debezium/kafka:1.3 \
    watch-topic -a -k dbserver1.inventory.customers

docker logs --follow watcher
