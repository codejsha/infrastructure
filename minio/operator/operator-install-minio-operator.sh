#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

# kubectl minio init --namespace minio-operator

kubectl minio init --output > minio-operator.yaml
kubectl apply --namespace minio-operator --filename minio-operator.yaml

######################################################################

### delete

# kubectl minio delete --namespace minio-operator

# kubectl delete --namespace minio-operator --filename minio-operator.yaml
