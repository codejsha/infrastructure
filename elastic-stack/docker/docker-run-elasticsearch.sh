#!/bin/bash
# trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
# set -o errexit
# set -o errtrace

docker network create elastic-network

docker run \
    --detach \
    --name elasticsearch \
    --network elastic-network \
    --publish 9200:9200 \
    --publish 9300:9300 \
    --env "discovery.type=single-node" \
    docker.elastic.co/elasticsearch/elasticsearch:7.13.2
