#!/bin/bash

docker run \
    --interactive \
    --tty \
    --name tomcat9 \
    --mount type=bind,src=/mnt/share,dst=/mnt/share \
    --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
    tomcat:9.0.40-jdk11-openjdk
