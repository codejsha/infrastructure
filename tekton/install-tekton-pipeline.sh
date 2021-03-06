#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

NAMESPACE="tekton-pipelines"
kubectl create namespace ${NAMESPACE}
kubectl config set-context --current --namespace="${NAMESPACE}"

# kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
TEKTON_PIPELINE_VERSION="0.16.3"
kubectl apply --filename https://github.com/tektoncd/pipeline/releases/download/v${TEKTON_PIPELINE_VERSION}/release.yaml
