#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

helm repo add minio https://helm.min.io
helm repo update

export PASSWORD="${PASSWORD}"

envsubst < ./helm-chart-values.yaml > ./helm-chart-values-temp.yaml

NAMESPACE="minio-system"

# helm install my-minio \
helm upgrade --install my-minio \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values-temp.yaml \
    --version 8.0.9 \
    minio/minio
