#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

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
