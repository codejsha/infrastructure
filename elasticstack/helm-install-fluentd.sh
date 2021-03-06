#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

NAMESPACE="elastic-system"

# helm install my-fluentd \
helm upgrade --install my-fluentd \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values-fluentd.yaml \
    --version 3.6.1 \
    bitnami/fluentd
