#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

NAMESPACE="kafka-system"

# helm install my-kafka \
helm upgrade --install my-kafka \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values-kafka.yaml \
    --version 12.4.3 \
    bitnami/kafka
