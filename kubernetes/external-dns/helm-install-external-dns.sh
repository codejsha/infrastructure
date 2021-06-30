#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

NAMESPACE="external-dns"

# helm install my-external-dns \
helm upgrade --install my-external-dns \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values values-coredns.yaml \
    --version 4.9.1 \
    bitnami/external-dns
