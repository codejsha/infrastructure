#!/usr/bin/bash

helm repo add jetstack https://charts.jetstack.io
helm repo update

NAMESPACE="cert-manager"
kubectl create namespace ${NAMESPACE}

# helm install cert-manager \
helm upgrade --install cert-manager \
    --namespace ${NAMESPACE} \
    --set installCRDs="true" \
    --version v1.0.1 \
    jetstack/cert-manager
