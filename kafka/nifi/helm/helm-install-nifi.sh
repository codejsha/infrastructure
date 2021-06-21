#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

helm repo add cetic https://cetic.github.io/helm-charts
helm repo update

NAMESPACE="kafka-system"

# helm install my-nifi \
helm upgrade --install my-nifi \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values-nifi.yaml \
    --version 0.6.1 \
    cetic/nifi
