#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

KIALI_PODNAME="$(kubectl get pods -l app="kiali" -o custom-columns=:metadata.name)"

kubectl create secret generic kiali --namespace istio-system --from-literal=username=admin --from-literal=passphrase=admin
kubectl delete pods ${KIALI_PODNAME}
