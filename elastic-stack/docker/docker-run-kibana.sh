#!/bin/bash
# trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
# set -o errexit
# set -o errtrace

docker run \
    --detach \
    --name kibana \
    --network elastic-network \
    --publish 5601:5601 \
    --env "ELASTICSEARCH_HOSTS=http://elasticsearch:9200" \
    docker.elastic.co/kibana/kibana:7.13.2
