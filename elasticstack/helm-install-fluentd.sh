#!/bin/bash

NAMESPACE="elastic-system"

# helm install my-fluentd \
helm upgrade --install my-fluentd \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values-fluentd.yaml \
    --version 3.6.1 \
    bitnami/fluentd
