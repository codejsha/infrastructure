#!/bin/bash

kubectl apply --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/grafana.yaml --namespace istio-system
kubectl apply --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/jaeger.yaml --namespace istio-system
kubectl apply --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/kiali.yaml --namespace istio-system
kubectl apply --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/prometheus.yaml --namespace istio-system
