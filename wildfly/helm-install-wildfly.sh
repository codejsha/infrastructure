#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

export PASSWORD="${PASSWORD}"

envsubst < ./chart-values.yaml > ./chart-values-temp.yaml

NAMESPACE="wildfly-system"

# helm install my-wildfly \
helm upgrade --install my-wildfly \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values chart-values-temp.yaml \
    --version 8.2.3 \
    bitnami/wildfly
