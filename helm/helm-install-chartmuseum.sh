#!/bin/bash

NAMESPACE="chart-system"

# helm install my-chartmuseum \
helm upgrade --install my-chartmuseum \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values chart-values.yaml \
    --version 2.14.2 \
    stable/chartmuseum
