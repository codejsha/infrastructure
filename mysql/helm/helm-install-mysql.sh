#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

USERNAME="${USERNAME}"
PASSWORD="${PASSWORD}"

export ROOT_PASSWORD="${PASSWORD}"
export DATABASE_USERNAME="${USERNAME}"
export DATABASE_PASSWORD="${PASSWORD}"
# export REPLICATION_USERNAME="${USERNAME}"
# export REPLICATION_PASSWORD="${PASSWORD}"

envsubst < ./values.yaml > ./values-temp.yaml

NAMESPACE="mysql-system"

# helm install my-mysql \
helm upgrade --install my-mysql \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values values-temp.yaml \
    --version 8.4.2 \
    bitnami/mysql
