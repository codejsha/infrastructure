#!/bin/bash

export AWS_ACCESS_KEY="${AWS_ACCESS_KEY}"
export AWS_SECRET_KEY="${AWS_SECRET_KEY}"

envsubst < ./chart-values.yaml > ./chart-values-temp.yaml

NAMESPACE="chart-system"

# helm install my-chartmuseum \
helm upgrade --install my-chartmuseum \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values chart-values-temp.yaml \
    --version 2.14.2 \
    stable/chartmuseum
