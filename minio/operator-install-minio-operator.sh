#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

NAMESPACE="minio-operator"

kubectl minio init --namespace ${NAMESPACE}
# kubectl minio delete --namespace ${NAMESPACE}
