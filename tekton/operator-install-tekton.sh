#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

### requirements:
### kubernetes cluster, kubectl, tkn

NAMESPACE="tekton-pipelines"
kubectl create namespace ${NAMESPACE}
kubectl config set-context --current --namespace "${NAMESPACE}"

kubectl apply --filename https://storage.googleapis.com/tekton-releases/operator/latest/release.notags.yaml

### check
# tkn version
# kubectl get tektonpipelines cluster --output jsonpath='{.status.conditions[0]}'
