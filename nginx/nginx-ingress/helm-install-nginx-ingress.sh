#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

NAMESPACE="ingress-nginx"

# helm install my-ingress \
helm upgrade --install my-ingress \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --version 3.25.0 \
    ingress-nginx/ingress-nginx
