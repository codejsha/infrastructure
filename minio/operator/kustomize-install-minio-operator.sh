#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

git clone https://github.com/minio/operator.git
# gh repo clone minio/operator

cd operator

### install
kustomize build . | kubectl apply --filename -

### uninstall
# kustomize build . | kubectl delete --filename -
