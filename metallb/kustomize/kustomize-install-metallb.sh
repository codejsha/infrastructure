#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

export SECRET_KEY="$(openssl rand -base64 128)"

envsubst < ./memberlist-secret.yaml > ./memberlist-secret-temp.yaml

### install
kustomize build . | kubectl apply --filename -

### uninstall
# kustomize build . | kubectl delete --filename -
