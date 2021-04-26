#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

### krew

### tenant namespace
# kubectl create namespace minio-tenant

### secret
# kubectl apply --namespace minio-tenant --filename tenant-creds-secret.yaml
# kubectl apply --namespace minio-tenant --filename tenant-console-secret.yaml

### certificate
# bash ./create-vault-issuer.sh
# kubectl apply --namespace minio-tenant --filename tenant-certificate.yaml
# kubectl apply --namespace minio-tenant --filename tenant-console-certificate.yaml

### tenant
# bash ./operator-create-tenant.sh

### ingress
# kubectl apply --namespace minio-tenant --filename tenant-console-ingress.yaml
# kubectl apply --namespace minio-tenant --filename tenant-ingress.yaml

######################################################################

### kustomize

### tenant namespace
kubectl create namespace minio-tenant

### secret
kubectl apply --namespace minio-tenant --filename tenant-creds-secret.yaml
kubectl apply --namespace minio-tenant --filename tenant-console-secret.yaml

### certificate
bash ./create-vault-issuer.sh
kubectl apply --namespace minio-tenant --filename tenant-certificate.yaml
kubectl apply --namespace minio-tenant --filename tenant-console-certificate.yaml

### tenant
kubectl apply --namespace minio-tenant --filename tenant.yaml

### ingress
kubectl apply --namespace minio-tenant --filename tenant-console-ingress.yaml
kubectl apply --namespace minio-tenant --filename tenant-ingress.yaml
