#!/bin/bash

docker container run \
    --detach \
    --rm \
    --name kafka \
    --publish 9092:9092 \
    --link zookeeper:zookeeper \
    --env TZ="Asia/Seoul" \
    debezium/kafka:1.3

docker logs --follow kafka
