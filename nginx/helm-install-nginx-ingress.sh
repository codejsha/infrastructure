#!/bin/bash

NAMESPACE="ingress-nginx"

# helm install my-ingress \
helm upgrade --install my-ingress \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --version 1.41.2 \
    stable/nginx-ingress
