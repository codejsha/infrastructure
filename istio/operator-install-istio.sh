#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

istioctl operator init

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
