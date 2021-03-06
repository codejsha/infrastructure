#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

TENANT_NAME="minio-tenant-1"
NAMESPACE="minio-tenant"

kubectl minio tenant delete \
    --name ${TENANT_NAME} \
    --namespace ${NAMESPACE}
