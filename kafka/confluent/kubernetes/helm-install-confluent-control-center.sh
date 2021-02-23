#!/bin/bash

NAMESPACE="confluent-operator"
RELEASE_NAME="confluent-control-center"
KUBE_CONTEXT="$(kubectl config current-context)"

# helm install ${RELEASE_NAME} \
helm upgrade --install ${RELEASE_NAME} \
    --kube-context ${KUBE_CONTEXT} \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values-private.yaml \
    --set controlcenter.enabled=true \
    ./confluent-operator/helm/confluent-operator
