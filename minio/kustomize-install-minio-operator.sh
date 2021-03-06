#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

git clone https://github.com/minio/operator.git
# gh repo clone minio/operator

cd operator

### install
kustomize build . | kubectl apply -f -

### uninstall
# kustomize build . | kubectl delete -f -
