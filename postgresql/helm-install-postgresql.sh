#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

export PASSWORD="${PASSWORD}"

envsubst < ./helm-chart-values.yaml > ./helm-chart-values-temp.yaml

NAMESPACE="postgres-system"

# helm install my-postgres \
helm upgrade --install my-postgres \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values-temp.yaml \
    --version 10.3.3 \
    bitnami/postgresql
