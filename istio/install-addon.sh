#!/bin/bash

kubectl apply --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/grafana.yaml
kubectl apply --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/jaeger.yaml
kubectl apply --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/kiali.yaml
kubectl apply --filename https://raw.githubusercontent.com/istio/istio/master/samples/addons/prometheus.yaml
