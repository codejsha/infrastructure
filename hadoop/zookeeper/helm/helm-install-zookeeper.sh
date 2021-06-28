#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

NAMESPACE="zookeeper-system"

# helm install my-zookeeper \
helm upgrade --install my-zookeeper \
    --create-namespace \
    --namespace ${NAMESPACE} \
    incubator/zookeeper
