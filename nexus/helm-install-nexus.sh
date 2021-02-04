#!/bin/bash

helm repo add oteemocharts https://oteemo.github.io/charts
helm repo update

NAMESPACE="nexus-system"

# helm install my-nexus \
helm upgrade --install my-nexus \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values.yaml \
    --version 4.2.0 \
    oteemocharts/sonatype-nexus
