#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

ARGO_ROLLOUTS_VERSION="v0.10.2"

kubectl create namespace argo-rollouts
kubectl apply --namespace argo-rollouts --filename https://raw.githubusercontent.com/argoproj/argo-rollouts/${ARGO_ROLLOUTS_VERSION}/manifests/install.yaml
