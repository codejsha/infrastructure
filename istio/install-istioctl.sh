#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

curl -sL https://istio.io/downloadIstioctl | sh -
# curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.9.3 TARGET_ARCH=x86_64 sh -

### add path
# export PATH=${PATH}:${HOME}/.istioctl/bin
