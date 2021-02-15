#!/bin/bash

NAMESPACE="confluent-operator"
RELEASE_PREFIX="confluent"
RELEASE_NAME="${RELEASE_PREFIX}-sr-replicator-connect-c3"
KUBE_CONTEXT="$(kubectl config current-context)"

# helm install ${RELEASE_NAME} \
# helm upgrade --install ${RELEASE_NAME} \
helm upgrade ${RELEASE_NAME} \
    --kube-context ${KUBE_CONTEXT} \
    --namespace ${NAMESPACE} \
    --values helm-chart-values.yaml \
    --set connect.enabled=true \
    --set schemaregistry.enabled=true \
    --set replicator.enabled=true \
    --set ksql.enabled=true \
    --set controlcenter.enabled=true \
    ./confluent-operator/helm/confluent-operator
