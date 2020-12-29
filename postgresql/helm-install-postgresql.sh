#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

export PASSWORD="${PASSWORD}"

envsubst < ./chart-values.yaml > ./chart-values-temp.yaml

NAMESPACE="postgres-system"

# helm install my-postgres \
helm upgrade --install my-postgres \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values chart-values-temp.yaml \
    --version 10.2.0 \
    bitnami/postgresql
