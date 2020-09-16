#!/usr/bin/bash

helm repo add jfrog https://charts.jfrog.io
helm repo update

NAMESPACE="artifactory-system"
kubectl create namespace ${NAMESPACE}

# helm install my-artifactory-oss \
helm upgrade --install my-artifactory-oss \
    --namespace ${NAMESPACE} \
    --set artifactory.nginx.enabled="false" \
    --set artifactory.ingress.enabled="true" \
    --set artifactory.ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set artifactory.ingress.hosts={"artifactory.example.com"} \
    --set artifactory.postgresql.postgresqlUsername="admin" \
    --set artifactory.postgresql.postgresqlPassword="changeit" \
    --version 2.3.1 \
    artifactory-oss
