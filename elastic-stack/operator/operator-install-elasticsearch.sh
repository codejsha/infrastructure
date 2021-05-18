#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

kubectl apply --namespace elastic-system --filename elasticsearch.yaml

# kubectl get secret elasticstack-es-elastic-user --output jsonpath='{.data.elastic}' --namespace elastic-system | base64 --decode; echo
