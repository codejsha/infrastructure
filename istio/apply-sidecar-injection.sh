#!/bin/bash

NAMESPACE="${1}"

### automatic sidecar injection
kubectl label namespace ${NAMESPACE} istio-injection=enabled
kubectl get namespace -L istio-injection

### manual sidecar injection
# kubectl apply -f <(istioctl kube-inject -f httpbin.yaml)

istioctl proxy-status
