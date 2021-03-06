#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

kubectl apply -f kibana.yaml

# kubectl get secret elasticstack-es-elastic-user -o=jsonpath='{.data.elastic}' -n elastic-system | base64 --decode; echo
