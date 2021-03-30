#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

ARGO_VERSION="v2.12.10"

kubectl create namespace argo
kubectl apply --namespace argo --filename https://raw.githubusercontent.com/argoproj/argo/${ARGO_VERSION}/manifests/install.yaml
