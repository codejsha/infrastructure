#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

### krew
# bash ./operator-install-minio.sh
# kubectl apply --namespace minio-operator --filename operator-console-ingress.yaml

######################################################################

### kustomize
bash ./kustomize-install-minio-operator.sh
kubectl apply --namespace minio-operator --filename operator-console-ingress.yaml
