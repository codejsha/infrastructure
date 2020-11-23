#!/bin/bash

docker run \
    --detach \
    --rm \
    --name zookeeper \
    --publish 2181:2181 \
    --publish 2888:2888 \
    --publish 3888:3888 \
    --env TZ="Asia/Seoul" \
    debezium/zookeeper:1.3

docker logs --follow zookeeper
