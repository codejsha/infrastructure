#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

export ROOT_PASSWORD="${ROOT_PASSWORD}"
export USERNAME="${USERNAME}"
export PASSWORD="${PASSWORD}"
export REPLICATION_USERNAME="${REPLICATION_USERNAME}"
export REPLICATION_PASSWORD="${REPLICATION_PASSWORD}"

envsubst < ./chart-values.yaml > ./chart-values-temp.yaml

NAMESPACE="mysql-system"

# helm install my-mysql \
helm upgrade --install my-mysql \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values chart-values-temp.yaml \
    --version 8.2.3 \
    bitnami/mysql
