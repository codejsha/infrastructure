#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

curl -sL https://istio.io/downloadIstioctl | sh -
# curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.9.1 TARGET_ARCH=x86_64 sh -

export PATH=$PATH:$HOME/.istioctl/bin
istioctl version

istioctl operator init
kubectl create namespace istio-system

### profile list
istioctl profile list
### Istio configuration profiles:
###     minimal
###     preview
###     remote
###     default
###     demo
###     empty

### install
# istioctl install --set profile=default
istioctl install --skip-confirmation --set profile=default
# istioctl install --skip-confirmation --set profile=default \
#    --set meshConfig.accessLogFile=/dev/stdout

### verify
istioctl manifest generate --set profile=default | istioctl verify-install -f -
