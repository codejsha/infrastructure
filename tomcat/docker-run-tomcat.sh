#!/bin/bash

docker container run \
    --detach \
    --name tomcat9 \
    --publish 8080:8080 \
    --mount type=bind,src=/mnt/share,dst=/mnt/share \
    --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
    tomcat:9.0.41-jdk11-openjdk
