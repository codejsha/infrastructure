#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

kubectl krew install ctx
kubectl krew install cert-manager
kubectl krew install ingress-nginx
kubectl krew install minio
kubectl krew install ns
kubectl krew install popeye
kubectl krew install score
kubectl krew install sniff
kubectl krew install tail
kubectl krew install tree
