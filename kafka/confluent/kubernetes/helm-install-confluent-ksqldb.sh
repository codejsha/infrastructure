#!/bin/bash

NAMESPACE="confluent-operator"
RELEASE_NAME="confluent-ksqldb"
KUBE_CONTEXT="$(kubectl config current-context)"

# helm install ${RELEASE_NAME} \
helm upgrade --install ${RELEASE_NAME} \
    --kube-context ${KUBE_CONTEXT} \
    --namespace ${NAMESPACE} \
    --values helm-chart-values-private.yaml \
    --set ksql.enabled=true \
    ./confluent-operator/helm/confluent-operator
