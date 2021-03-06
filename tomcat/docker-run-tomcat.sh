#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

docker container run \
    --detach \
    --name tomcat9 \
    --publish 8080:8080 \
    --mount type=bind,src=/mnt/share,dst=/mnt/share \
    --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
    tomcat:9.0.41-jdk11-openjdk
