#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

kubectl apply -f https://download.elastic.co/downloads/eck/1.4.0/all-in-one.yaml
# kubectl logs -f statefulset.apps/elastic-operator -n elastic-system

### delete
# kubectl delete -f https://download.elastic.co/downloads/eck/1.4.0/all-in-one.yaml
