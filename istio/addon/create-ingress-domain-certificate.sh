#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

kubectl apply --namespace istio-system --filename grafana-certificate.yaml
kubectl apply --namespace istio-system --filename kiali-certificate.yaml
kubectl apply --namespace istio-system --filename prometheus-certificate.yaml
kubectl apply --namespace istio-system --filename tracing-certificate.yaml
