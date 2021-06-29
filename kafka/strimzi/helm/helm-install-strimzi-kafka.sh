#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

NAMESPACE="kafka-system"

helm repo add strimzi https://strimzi.io/charts
helm repo update

# helm install my-kafka-operator \
helm upgrade --install my-kafka-operator \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --version 0.20.1 \
    strimzi/strimzi-kafka-operator

    # --values values.yaml \

kubectl apply --filename strimzi-kafka-cluster.yaml
