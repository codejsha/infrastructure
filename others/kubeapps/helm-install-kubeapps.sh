#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

NAMESPACE="kubeapps-system"

# helm install my-kubeapps \
helm upgrade --install my-kubeapps \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set useHelm3="true" \
    --set ingress.enabled="true" \
    --set ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set ingress.hostname="kubeapps.example.com" \
    --version 3.7.2 \
    bitnami/kubeapps
