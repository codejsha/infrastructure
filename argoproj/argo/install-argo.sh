#!/usr/bin/bash
# https://github.com/argoproj/argo

ARGO_VERSION="v2.11.0"

kubectl create namespace argo
kubectl apply -n argo -f https://raw.githubusercontent.com/argoproj/argo/${ARGO_VERSION}/manifests/install.yaml
