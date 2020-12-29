#!/bin/bash

helm repo add cetic https://cetic.github.io/helm-charts
helm repo update

NAMESPACE="kafka-system"

# helm install my-nifi \
helm upgrade --install my-nifi \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values nifi-chart-values.yaml \
    --version 0.6.1 \
    cetic/nifi
