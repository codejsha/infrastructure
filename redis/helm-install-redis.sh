#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

export PASSWORD="${PASSWORD}"

envsubst < ./helm-chart-values.yaml > ./helm-chart-values-temp.yaml

NAMESPACE="redis-system"

# helm install my-redis \
helm upgrade --install my-redis \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values-temp.yaml \
    --version 12.2.4 \
    bitnami/redis
