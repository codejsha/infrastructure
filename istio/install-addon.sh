#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

kubectl apply --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/grafana.yaml --namespace istio-system
kubectl apply --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/jaeger.yaml --namespace istio-system
kubectl apply --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/kiali.yaml --namespace istio-system
kubectl apply --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/prometheus.yaml --namespace istio-system
