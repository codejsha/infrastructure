#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

helm repo add elastic https://helm.elastic.co
helm repo update

NAMESPACE="elastic-system"

helm install elastic-operator \
    --create-namespace \
    --namespace ${NAMESPACE} \
    elastic/eck-operator
