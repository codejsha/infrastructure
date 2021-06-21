#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

git clone https://github.com/istio/istio
git checkout origin/release-1.9
kubectl apply --namespace istio-system --filename istio/samples/addons

# kubectl apply --namespace istio-system --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/grafana.yaml
# kubectl apply --namespace istio-system --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/jaeger.yaml
# kubectl apply --namespace istio-system --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/kiali.yaml
# kubectl apply --namespace istio-system --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/prometheus.yaml
# kubectl apply --namespace istio-system --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/extras/prometheus-operator.yaml
# kubectl apply --namespace istio-system --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/extras/zipkin.yaml
