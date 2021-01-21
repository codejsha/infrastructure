#!/bin/bash

### requirements:
### sudo yum install -y httpd-tools
### mc mb myminio/harbor-storage

helm repo add harbor https://helm.goharbor.io
helm repo update

export HARBOR_ADMIN_PASSWORD="${PASSWORD}"
export HARBOR_SECRET_KEY="${HARBOR_SECRET_KEY}" # Must be a string of 16 chars
export REGISTRY_USERNAME="admin"
export REGISTRY_PASSWORD="${PASSWORD}"
export REGISTRY_HTPASSWD="$(htpasswd -nbBC10 ${REGISTRY_USERNAME} ${REGISTRY_PASSWORD})"
export INTERNAL_DATABASE_PASSWORD="${PASSWORD}"
export EXTERNAL_DATABASE_USERNAME="admin"
export EXTERNAL_DATABASE_PASSWORD="${PASSWORD}"
export AWS_ACCESS_KEY="${AWS_ACCESS_KEY}"
export AWS_SECRET_KEY="${AWS_SECRET_KEY}"

envsubst < ./helm-chart-values.yaml > ./helm-chart-values-temp.yaml

NAMESPACE="harbor-system"

# helm install my-harbor \
helm upgrade --install my-harbor \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values-temp.yaml \
    --version 1.5.2 \
    harbor/harbor
