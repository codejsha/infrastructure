#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
# set -o xtrace

helm repo add jetstack https://charts.jetstack.io
helm repo update

NAMESPACE="cert-manager"

# helm install my-cert-manager \
helm upgrade --install my-cert-manager \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set installCRDs="true" \
    --version v1.0.1 \
    jetstack/cert-manager
