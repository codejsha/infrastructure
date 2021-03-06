#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
# set -o xtrace

ARGO_EVENTS_VERSION="v1.1.0"

kubectl create namespace argo-events
kubectl apply -n argo-events -f https://raw.githubusercontent.com/argoproj/argo-events/${ARGO_EVENTS_VERSION}/manifests/install.yaml
