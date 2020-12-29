#!/bin/bash

NAMESPACE="kafka-system"

# helm install my-kafka \
helm upgrade --install my-kafka \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values kafka-chart-values.yaml \
    --version 12.4.3 \
    bitnami/kafka
