#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

NAMESPACE="zookeeper-system"

# helm install my-zookeeper \
helm upgrade --install my-zookeeper \
    --create-namespace \
    --namespace ${NAMESPACE} \
    incubator/zookeeper
