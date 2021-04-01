#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

NAMESPACE="tomcat-system"
kubectl create namespace ${NAMESPACE}
kubectl label namespace ${NAMESPACE} istio-injection=enabled

# helm install my-tomcat \
helm upgrade --install my-tomcat \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values.yaml \
    --version 8.0.0 \
    bitnami/tomcat
