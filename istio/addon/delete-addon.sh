#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

kubectl delete --namespace istio-system --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/grafana.yaml
kubectl delete --namespace istio-system --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/jaeger.yaml
kubectl delete --namespace istio-system --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/kiali.yaml
kubectl delete --namespace istio-system --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/prometheus.yaml
kubectl delete --namespace istio-system --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/extras/prometheus-operator.yaml
kubectl delete --namespace istio-system --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/extras/zipkin.yaml
