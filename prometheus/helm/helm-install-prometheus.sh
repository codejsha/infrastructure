#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo update

NAMESPACE="prometheus-system"

# helm install my-prometheus \
helm upgrade --install my-prometheus \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values values.yaml \
    --version 11.16.9 \
    prometheus-community/prometheus
