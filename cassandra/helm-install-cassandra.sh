#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

NAMESPACE="cassandra-system"

# helm install my-cassandra \
helm upgrade --install my-cassandra \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values.yaml \
    --version 7.1.2 \
    bitnami/cassandra
