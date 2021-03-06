#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
# set -o xtrace

NAMESPACE="cassandra-system"
RELEASE_NAME="my-cassandra"

kubectl exec --namespace ${NAMESPACE} \
    $(kubectl get pods --namespace ${NAMESPACE} \
        --selector app.kubernetes.io/instance=${RELEASE_NAME} \
        --output jsonpath='{.items[0].metadata.name}') \
    --container cassandra \
    -- nodetool status
