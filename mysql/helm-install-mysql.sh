#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

USERNAME="${USERNAME}"
PASSWORD="${PASSWORD}"

export ROOT_PASSWORD="${PASSWORD}"
export DATABASE_USERNAME="${USERNAME}"
export DATABASE_PASSWORD="${PASSWORD}"
# export REPLICATION_USERNAME="${USERNAME}"
# export REPLICATION_PASSWORD="${PASSWORD}"

envsubst < ./helm-chart-values.yaml > ./helm-chart-values-temp.yaml

NAMESPACE="mysql-system"

# helm install my-mysql \
helm upgrade --install my-mysql \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values-temp.yaml \
    --version 8.4.2 \
    bitnami/mysql
