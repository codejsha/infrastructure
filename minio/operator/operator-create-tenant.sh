#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

TENANT_NAME="minio-tenant-1"
NAMESPACE="minio-tenant"

kubectl create namespace ${NAMESPACE}

kubectl minio tenant create \
    --name ${TENANT_NAME} \
    --namespace ${NAMESPACE} \
    --servers 3 \
    --volumes 12 \
    --capacity 12Ti \
    --storage-class local-path

# kubectl minio tenant create \
#     --name ${TENANT_NAME} \
#     --namespace ${NAMESPACE} \
#     --servers 3 \
#     --volumes 12 \
#     --capacity 12Ti \
#     --storage-class local-path \
#     -o > tenant.yaml
# kubectl apply --filename tenant.yaml
