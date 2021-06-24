#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

USERNAME="admin"
PASSWORD="${PASSWORD}"

export ROOT_PASSWORD="${ROOT_PASSWORD}"
export USERNAME="${USERNAME}"
export PASSWORD="${PASSWORD}"
export REPLICATION_USERNAME="${USERNAME}"
export REPLICATION_PASSWORD="${PASSWORD}"

envsubst < ./values.yaml > ./values-temp.yaml

NAMESPACE="mongodb-system"

# helm install my-mongodb \
helm upgrade --install my-mongodb \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values values-temp.yaml \
    --version 8.2.3 \
    bitnami/mongodb
