#!/usr/bin/bash
# https://github.com/tektoncd/triggers

NAMESPACE="tekton-pipelines"
kubectl create namespace ${NAMESPACE}
kubectl config set-context --current --namespace="${NAMESPACE}"

# kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
TEKTON_TRIGGER_VERSION="0.8.1"
kubectl apply --filename https://github.com/tektoncd/triggers/releases/download/v${TEKTON_TRIGGER_VERSION}/release.yaml
