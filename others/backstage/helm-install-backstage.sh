#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

git clone https://github.com/spotify/backstage.git
# gh repo clone spotify/backstage

NAMESPACE="backstage-system"

# helm install my-backstage \
helm upgrade --install my-backstage \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values.yaml \
    ./backstage/contrib/chart/backstage
