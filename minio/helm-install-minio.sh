#!/bin/bash

helm repo add minio https://helm.min.io
helm repo update

export PASSWORD="${PASSWORD}"

envsubst < ./chart-values.yaml > ./chart-values-temp.yaml

NAMESPACE="minio-system"

# helm install my-minio \
helm upgrade --install my-minio \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values chart-values-temp.yaml \
    --version 8.0.8 \
    minio/minio
