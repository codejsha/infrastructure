#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

kubectl krew install ctx
kubectl krew install minio
kubectl krew install ns
kubectl krew install popeye
kubectl krew install sniff
kubectl krew install tail
kubectl krew install tree
