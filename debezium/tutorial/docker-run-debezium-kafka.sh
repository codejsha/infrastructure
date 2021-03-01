#!/bin/bash

docker container run \
    --detach \
    --rm \
    --name kafka \
    --link zookeeper:zookeeper \
    --publish 9092:9092 \
    --env TZ="Asia/Seoul" \
    debezium/kafka:1.3

docker logs --follow kafka
