#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

STRIMZI_NAMESPACE="kafka-system"

######################################################################

function create_kafka_cluster {
    kubectl apply \
        --namespace ${STRIMZI_NAMESPACE} \
        --filename strimzi-kafka-cluster.yaml
}

function delete_kafka_cluster {
    kubectl delete \
        --namespace ${STRIMZI_NAMESPACE} \
        --filename strimzi-kafka-cluster.yaml
}

######################################################################

create_kafka_cluster
# delete_kafka_cluster
