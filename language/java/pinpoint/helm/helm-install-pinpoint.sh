#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

git clone https://github.com/pinpoint-apm/pinpoint-kubernetes.git
# gh repo clone pinpoint-apm/pinpoint-kubernetes

export MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD}"
export MYSQL_USERNAME="${MYSQL_USERNAME}"
export MYSQL_PASSWORD="${MYSQL_PASSWORD}"

envsubst < ./values.yaml > ./values-temp.yaml

NAMESPACE="pinpoint-system"

# helm install my-pinpoint \
helm upgrade --install my-pinpoint \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values values-temp.yaml \
    ./pinpoint
