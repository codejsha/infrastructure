#!/bin/bash

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo update

NAMESPACE="prometheus-system"

# helm install my-prometheus \
helm upgrade --install my-prometheus \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values chart-values.yaml \
    --version 11.16.9 \
    prometheus-community/prometheus
