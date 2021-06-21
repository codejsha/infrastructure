#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

NAMESPACE="cassandra-system"
RELEASE_NAME="my-cassandra"

kubectl exec --namespace ${NAMESPACE} \
    $(kubectl get pods \
        --namespace ${NAMESPACE} \
        --selector app.kubernetes.io/instance=${RELEASE_NAME} \
        --output jsonpath='{.items[0].metadata.name}') \
    --container cassandra \
    -- nodetool status
