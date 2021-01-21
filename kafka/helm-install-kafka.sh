#!/bin/bash

NAMESPACE="kafka-system"

# helm install my-kafka \
helm upgrade --install my-kafka \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values-kafka.yaml \
    --version 12.4.3 \
    bitnami/kafka
