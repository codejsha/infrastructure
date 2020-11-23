#!/bin/bash
# https://github.com/tektoncd/operator
# prerequisites: kubernetes cluster, kubectl, tkn

NAMESPACE="tekton-pipelines"
kubectl create namespace ${NAMESPACE}
kubectl config set-context --current --namespace="${NAMESPACE}"

kubectl apply -f https://storage.googleapis.com/tekton-releases/operator/latest/release.notags.yaml

### check
# tkn version
# kubectl get tektonpipelines cluster -o jsonpath='{.status.conditions[0]}'
