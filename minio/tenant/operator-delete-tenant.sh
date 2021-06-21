#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

TENANT_NAME="minio-tenant-1"
NAMESPACE="minio-tenant"

kubectl minio tenant delete \
    ${TENANT_NAME} \
    --namespace ${NAMESPACE}
