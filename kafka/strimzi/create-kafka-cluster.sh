#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

STRIMZI_NAMESPACE="kafka-system"

######################################################################

function create_kafka_cluster {
    kubectl apply \
        --filename strimzi-kafka-cluster.yaml \
        -n ${STRIMZI_NAMESPACE}
}

function delete_kafka_cluster {
    kubectl delete \
        --filename strimzi-kafka-cluster.yaml \
        -n ${STRIMZI_NAMESPACE}
}

######################################################################

create_kafka_cluster
# delete_kafka_cluster
