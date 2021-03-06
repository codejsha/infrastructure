#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

### requirements
###
### htpasswd:
### sudo yum install -y httpd-tools
###
### bucket:
### mc mb my-minio/harbor-storage
### mc mb minio-tenant-1/harbor-storage --insecure

helm repo add harbor https://helm.goharbor.io
helm repo update

PASSWORD="${PASSWORD}"
HARBOR_SECRET_KEY="${HARBOR_SECRET_KEY}"
AWS_ACCESS_KEY="${AWS_ACCESS_KEY}"
AWS_SECRET_KEY="${AWS_SECRET_KEY}"

export AWS_REGION_ENDPOINT="http://minio.example.com"
# export AWS_REGION_ENDPOINT="https://minio-tenant-1.example.com"
# export AWS_REGION_ENDPOINT="https://minio-hl.minio-tenant.svc.cluster.local:9000"
export AWS_ACCESS_KEY="${AWS_ACCESS_KEY}"
export AWS_SECRET_KEY="${AWS_SECRET_KEY}"

export HARBOR_ADMIN_PASSWORD="${PASSWORD}"
export HARBOR_SECRET_KEY="${HARBOR_SECRET_KEY}" # Must be a string of 16 chars
export REGISTRY_USERNAME="admin"
export REGISTRY_PASSWORD="${PASSWORD}"
export REGISTRY_HTPASSWD="$(htpasswd -nbBC10 ${REGISTRY_USERNAME} ${REGISTRY_PASSWORD})"
export INTERNAL_DATABASE_PASSWORD="${PASSWORD}"
export EXTERNAL_DATABASE_USERNAME="admin"
export EXTERNAL_DATABASE_PASSWORD="${PASSWORD}"

envsubst < ./helm-chart-values.yaml > ./helm-chart-values-temp.yaml

NAMESPACE="harbor-system"

# helm install my-harbor \
helm upgrade --install my-harbor \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values-temp.yaml \
    --version 1.5.3 \
    harbor/harbor
