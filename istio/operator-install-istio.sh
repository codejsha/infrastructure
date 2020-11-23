#!/bin/bash
# https://istio.io/latest/docs/setup/install/istioctl/
# https://istio.io/latest/docs/setup/install/operator/
# https://istio.io/latest/docs/setup/additional-setup/config-profiles/

curl -sL https://istio.io/downloadIstioctl | sh -
export PATH=$PATH:$HOME/.istioctl/bin
istioctl version

istioctl operator init
kubectl create namespace istio-system

istioctl profile list
### Istio configuration profiles:
###     minimal
###     preview
###     remote
###     default
###     demo
###     empty

istioctl install --set profile=default \
   --set meshConfig.accessLogFile=/dev/stdout

# kubectl get services -n istio-system
# kubectl get pods -n istio-system
