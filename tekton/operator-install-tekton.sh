#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

### requirements:
### kubernetes cluster, kubectl, tkn

NAMESPACE="tekton-pipelines"
kubectl create namespace ${NAMESPACE}
kubectl config set-context --current --namespace="${NAMESPACE}"

kubectl apply -f https://storage.googleapis.com/tekton-releases/operator/latest/release.notags.yaml

### check
# tkn version
# kubectl get tektonpipelines cluster -o jsonpath='{.status.conditions[0]}'
