#!/bin/bash

ARGO_EVENTS_VERSION="v1.0.0"

kubectl create namespace argo-events
kubectl apply -n argo-events -f https://raw.githubusercontent.com/argoproj/argo-events/${ARGO_EVENTS_VERSION}/manifests/install.yaml
