#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

NAMESPACE="tekton-pipelines"
kubectl create namespace ${NAMESPACE}
kubectl config set-context --current --namespace "${NAMESPACE}"

# kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
TEKTON_TRIGGER_VERSION="0.8.1"
kubectl apply --filename https://github.com/tektoncd/triggers/releases/download/v${TEKTON_TRIGGER_VERSION}/release.yaml
