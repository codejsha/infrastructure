#!/bin/bash
# https://github.com/argoproj/argo-cd

ARGOCD_VERSION="v1.7.7"

kubectl create namespace argocd
### Non HA
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/${ARGOCD_VERSION}/manifests/install.yaml
### HA
# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/${ARGOCD_VERSION}/manifests/ha/install.yaml
