#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

kubectl apply --filename https://github.com/jetstack/cert-manager/releases/download/v1.3.1/cert-manager.crds.yaml
kubectl apply --filename https://github.com/jetstack/cert-manager/releases/download/v1.3.1/cert-manager.yaml
