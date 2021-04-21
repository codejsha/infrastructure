#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

export PASSWORD="${PASSWORD}"

envsubst < ./helm-chart-values.yaml > ./helm-chart-values-temp.yaml

######################################################################

function helm_install_postgresql {
    local NAMESPACE="postgres-system"

    # helm install my-postgres \
    helm upgrade --install my-postgres \
        --create-namespace \
        --namespace ${NAMESPACE} \
        --values helm-chart-values-temp.yaml \
        --version 10.3.18 \
        bitnami/postgresql
}

function helm_install_postgresql_harbor {
    local NAMESPACE="harbor-system"

    # helm install my-harbor-postgres \
    helm upgrade --install my-harbor-postgres \
        --create-namespace \
        --namespace ${NAMESPACE} \
        --values helm-chart-values-temp.yaml \
        --version 10.3.18 \
        bitnami/postgresql
}

######################################################################

helm_install_postgresql
# helm_install_postgresql_harbor
