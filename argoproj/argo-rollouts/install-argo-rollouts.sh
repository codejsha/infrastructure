#!/usr/bin/bash

ARGO_ROLLOUTS_VERSION="v0.9.1"

kubectl create namespace argo-rollouts
kubectl apply -n argo-rollouts -f https://raw.githubusercontent.com/argoproj/argo-rollouts/${ARGO_ROLLOUTS_VERSION}/manifests/install.yaml