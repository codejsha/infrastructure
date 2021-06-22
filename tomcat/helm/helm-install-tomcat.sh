#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

NAMESPACE="tomcat-system"
kubectl create namespace ${NAMESPACE}
kubectl label namespace ${NAMESPACE} istio-injection=enabled

# helm install my-tomcat \
helm upgrade --install my-tomcat \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values values.yaml \
    --version 8.0.0 \
    bitnami/tomcat
