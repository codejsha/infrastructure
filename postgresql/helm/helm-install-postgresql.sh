#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

export PASSWORD="${PASSWORD}"

envsubst < ./values.yaml > ./values-temp.yaml

######################################################################

function helm_install_postgresql {
    local NAMESPACE="postgres-system"

    # helm install my-postgres \
    helm upgrade --install my-postgres \
        --create-namespace \
        --namespace ${NAMESPACE} \
        --values values-temp.yaml \
        --version 10.3.18 \
        bitnami/postgresql
}

function helm_install_postgresql_harbor {
    local NAMESPACE="harbor-system"

    # helm install my-harbor-postgres \
    helm upgrade --install my-harbor-postgres \
        --create-namespace \
        --namespace ${NAMESPACE} \
        --values values-temp.yaml \
        --values values-harbor.yaml \
        --version 10.3.18 \
        bitnami/postgresql
}

######################################################################

helm_install_postgresql
# helm_install_postgresql_harbor
