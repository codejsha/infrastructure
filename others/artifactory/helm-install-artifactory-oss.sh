#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

helm repo add jfrog https://charts.jfrog.io
helm repo update

NAMESPACE="artifactory-system"

# helm install my-artifactory-oss \
helm upgrade --install my-artifactory-oss \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set artifactory.nginx.enabled="false" \
    --set artifactory.ingress.enabled="true" \
    --set artifactory.ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set artifactory.ingress.hosts={"artifactory.example.com"} \
    --set artifactory.postgresql.postgresqlUsername="admin" \
    --set artifactory.postgresql.postgresqlPassword="${PASSWORD}" \
    --version 2.3.1 \
    artifactory-oss
