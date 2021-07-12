#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

helm repo add elastic https://helm.elastic.co
helm repo update

NAMESPACE="elastic-system"

helm upgrade --install my-elasticsearch \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values values.yaml \
    --version 7.13.2 \
    elastic/elasticsearch
