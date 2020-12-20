#!/bin/bash

helm repo add cmak-operator https://eshepelyuk.github.io/cmak-operator
helm repo update

NAMESPACE="kafka-system"

# helm install my-cmak-operator \
helm upgrade --install my-cmak-operator \
    --create-namespace \
    --values cmak-chart-values.yaml \
    --version 0.6.2 \
    cmak-operator/cmak-operator
