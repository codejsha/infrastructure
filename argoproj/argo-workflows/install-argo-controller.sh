#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

ARGO_VERSION="v3.1.1"

kubectl create namespace argo
kubectl apply --namespace argo --filename https://github.com/argoproj/argo-workflows/releases/download/v${ARGO_VERSION}/install.yaml
