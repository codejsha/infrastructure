#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

TENANT_NAME="minio-tenant-1"
NAMESPACE="minio-tenant"

STORAGE_CLASS="standard"
# STORAGE_CLASS="rook-ceph-block"
# STORAGE_CLASS="local-path"

kubectl create namespace ${NAMESPACE}

######################################################################

# kubectl minio tenant create \
#     ${TENANT_NAME} \
#     --namespace ${NAMESPACE} \
#     --servers 1 \
#     --volumes 4 \
#     --capacity 4Ti \
#     --storage-class ${STORAGE_CLASS}
# kubectl minio tenant create \
#     ${TENANT_NAME} \
#     --namespace ${NAMESPACE} \
#     --servers 3 \
#     --volumes 12 \
#     --capacity 12Ti \
#     --storage-class ${STORAGE_CLASS}

######################################################################

# kubectl minio tenant create \
#     ${TENANT_NAME} \
#     --namespace ${NAMESPACE} \
#     --servers 1 \
#     --volumes 4 \
#     --capacity 4Ti \
#     --storage-class ${STORAGE_CLASS} \
#     --output > tenant.yaml
# kubectl minio tenant create \
#     ${TENANT_NAME} \
#     --namespace ${NAMESPACE} \
#     --servers 3 \
#     --volumes 12 \
#     --capacity 12Ti \
#     --storage-class ${STORAGE_CLASS} \
#     --output > tenant.yaml

kubectl apply --namespace ${NAMESPACE} --filename tenant.yaml
