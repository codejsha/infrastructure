#!/bin/bash

docker container run \
    --detach \
    --rm \
    --name connect \
    --link zookeeper:zookeeper \
    --link kafka:kafka \
    --link mysql:mysql \
    --publish 8083:8083 \
    --env GROUP_ID="1" \
    --env CONFIG_STORAGE_TOPIC="my_connect_configs" \
    --env OFFSET_STORAGE_TOPIC="my_connect_offsets" \
    --env STATUS_STORAGE_TOPIC="my_connect_statuses" \
    --env TZ="Asia/Seoul" \
    debezium/connect:1.3

docker logs --follow connect
