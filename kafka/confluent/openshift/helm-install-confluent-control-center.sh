#!/bin/bash

NAMESPACE="confluent-operator"
RELEASE_NAME="confluent-control-center"
KUBE_CONTEXT="$(oc config current-context)"

# helm install ${RELEASE_NAME} \
# helm upgrade ${RELEASE_NAME} \
helm upgrade --install ${RELEASE_NAME} \
    --kube-context ${KUBE_CONTEXT} \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values.yaml \
    --values helm-chart-values-license.yaml \
    --set controlcenter.enabled="true" \
    ./confluent-operator/helm/confluent-operator

