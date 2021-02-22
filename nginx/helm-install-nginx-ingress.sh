#!/bin/bash

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

NAMESPACE="ingress-nginx"

# helm install my-ingress \
helm upgrade --install my-ingress \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --version 3.23.0 \
    ingress-nginx/ingress-nginx
