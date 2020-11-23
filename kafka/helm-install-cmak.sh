#!/usr/bin/bash

helm repo add cmak-operator https://eshepelyuk.github.io/cmak-operator

NAMESPACE="kafka-system"

# helm install my-cmak-operator \
helm upgrade --install my-cmak-operator \
    --create-namespace \
    --values cmak-values.yaml \
    --version 0.6.2 \
    cmak-operator/cmak-operator
