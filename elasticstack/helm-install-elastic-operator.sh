#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

helm repo add elastic https://helm.elastic.co
helm repo update

NAMESPACE="elastic-system"

helm install elastic-operator \
    --create-namespace \
    --namespace ${NAMESPACE} \
    elastic/eck-operator
