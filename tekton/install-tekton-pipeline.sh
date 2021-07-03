#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

NAMESPACE="tekton-pipelines"
kubectl create namespace ${NAMESPACE}
kubectl config set-context --current --namespace "${NAMESPACE}"

# kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
TEKTON_PIPELINE_VERSION="0.25.0"
kubectl apply --filename https://github.com/tektoncd/pipeline/releases/download/v${TEKTON_PIPELINE_VERSION}/release.yaml
