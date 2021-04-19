#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

NAMESPACE="minio-operator"

# kubectl minio init --namespace ${NAMESPACE}

kubectl minio init --output > minio-operator.yaml
kubectl apply --namespace ${NAMESPACE} minio-operator.yaml

# kubectl minio delete --namespace ${NAMESPACE}
