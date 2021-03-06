#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

NAMESPACE="tekton-pipelines"
kubectl create namespace ${NAMESPACE}
kubectl config set-context --current --namespace "${NAMESPACE}"

# kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml
TEKTON_DASHBOARD_VERSION="0.18.0"
kubectl apply --filename https://github.com/tektoncd/dashboard/releases/download/v${TEKTON_DASHBOARD_VERSION}/tekton-dashboard-release.yaml
