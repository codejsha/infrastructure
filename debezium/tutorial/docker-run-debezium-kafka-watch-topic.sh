#!/bin/bash

docker container run \
    --detach \
    --rm \
    --name watcher \
    --link zookeeper:zookeeper \
    --link kafka:kafka \
    --env TZ="Asia/Seoul" \
    debezium/kafka:1.3 \
    watch-topic -a -k dbserver1.inventory.customers

docker logs --follow watcher
