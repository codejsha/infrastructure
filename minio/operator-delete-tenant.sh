#!/bin/bash

TENANT_NAME="minio-tenant-1"
NAMESPACE="minio-tenant"

kubectl minio tenant delete \
    --name ${TENANT_NAME} \
    --namespace ${NAMESPACE}
