#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

KIALI_PODNAME="$(kubectl get pods -l app="kiali" -o custom-columns=:metadata.name)"

kubectl create secret generic kiali -n istio-system --from-literal=username=admin --from-literal=passphrase=admin
kubectl delete pods ${KIALI_PODNAME}
