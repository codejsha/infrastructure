#!/usr/bin/bash

helm repo add harbor https://helm.goharbor.io
helm repo update

ADMIN_PASSWORD="changeit"
SECRET_KEY="changeitchangeit"
REGISTRY_USERNAME="admin"
REGISTRY_PASSWORD="changeit"
REGISTRY_HTPASSWD="$(htpasswd -nbBC10 $REGISTRY_USERNAME $REGISTRY_PASSWORD)"
INTERNAL_DATABASE_PASSWORD="changeit"
EXTERNAL_DATABASE_PASSWORD="changeit"

NAMESPACE="harbor-system"
kubectl create namespace ${NAMESPACE}

# helm install my-harbor \
helm upgrade --install my-harbor \
    --namespace ${NAMESPACE} \
    --set harborAdminPassword="${ADMIN_PASSWORD}" \
    --set secretKey="${SECRET_KEY}" \
    --set registry.credential.username="${REGISTRY_USERNAME}" \
    --set registry.credential.password="${REGISTRY_PASSWORD}" \
    --set registry.credential.htpasswd="${REGISTRY_HTPASSWD}" \
    --set database.internal.password="${INTERNAL_DATABASE_PASSWORD}" \
    --set database.external.username="admin" \
    --set database.external.password="${EXTERNAL_DATABASE_PASSWORD}" \
    --set expose.ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set expose.ingress.hosts.core="core.harbor.example.com" \
    --set expose.ingress.hosts.notary="notary.harbor.example.com" \
    --set externalURL="https://core.harbor.example.com" \
    --set persistence.persistentVolumeClaim.registry.storageClass="rook-ceph-block" \
    --set persistence.persistentVolumeClaim.chartmuseum.storageClass="rook-ceph-block" \
    --set persistence.persistentVolumeClaim.jobservice.storageClass="rook-ceph-block" \
    --set persistence.persistentVolumeClaim.database.storageClass="rook-ceph-block" \
    --set persistence.persistentVolumeClaim.redis.storageClass="rook-ceph-block" \
    --set persistence.persistentVolumeClaim.trivy.storageClass="rook-ceph-block" \
    --version 1.4.0 \
    harbor/harbor

    ### for loadbalancer
    # --set expose.type="loadBalancer" \
    # --set expose.tls.commonName="core.harbor.example.com" \
    # --set expose.loadBalancer.IP="10.10.10.50" \
    # --set externalURL="core.harbor.example.com" \
