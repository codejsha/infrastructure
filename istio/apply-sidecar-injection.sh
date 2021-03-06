#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

NAMESPACE="${1}"

### automatic sidecar injection
kubectl label namespace ${NAMESPACE} istio-injection=enabled
kubectl get namespace -L istio-injection

### manual sidecar injection
# kubectl apply -f <(istioctl kube-inject -f httpbin.yaml)

istioctl proxy-status
