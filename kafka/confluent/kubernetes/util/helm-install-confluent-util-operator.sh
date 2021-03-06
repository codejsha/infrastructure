#!/bin/bash

NAMESPACE="confluent-operator"
RELEASE_PREFIX="confluent"
RELEASE_NAME="${RELEASE_PREFIX}-operator"
KUBE_CONTEXT="$(kubectl config current-context)"

# helm install ${RELEASE_NAME} \
# helm upgrade --install ${RELEASE_NAME} \
helm upgrade ${RELEASE_NAME} \
    --kube-context ${KUBE_CONTEXT} \
    --namespace ${NAMESPACE} \
    --values ../values.yaml \
    --set operator.enabled="true" \
    ./confluent-operator/helm/confluent-operator
