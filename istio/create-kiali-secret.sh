#!/bin/bash

KIALI_PODNAME="$(kubectl get pods -l app="kiali" -o custom-columns=:metadata.name)"

kubectl create secret generic kiali -n istio-system --from-literal=username=admin --from-literal=passphrase=admin
kubectl delete pods ${KIALI_PODNAME}
