#!/usr/bin/bash
# https://goharbor.io/
# https://github.com/goharbor/harbor

### required package:
### sudo yum install -y httpd-tools

helm repo add harbor https://helm.goharbor.io
helm repo update

HARBOR_ADMIN_PASSWORD="${PASSWORD}"
HARBOR_SECRET_KEY="${HARBOR_SECRET_KEY}" # Must be a string of 16 chars
REGISTRY_USERNAME="admin"
REGISTRY_PASSWORD="${PASSWORD}"
REGISTRY_HTPASSWD="$(htpasswd -nbBC10 ${REGISTRY_USERNAME} ${REGISTRY_PASSWORD})"
INTERNAL_DATABASE_PASSWORD="${PASSWORD}"
EXTERNAL_DATABASE_USERNAME="admin"
EXTERNAL_DATABASE_PASSWORD="${PASSWORD}"
AWS_ACCESS_KEY="<AWS_ACCESS_KEY>"
AWS_SECRET_KEY="<AWS_SECRET_KEY>"

NAMESPACE="harbor-system"
kubectl create namespace ${NAMESPACE}

# helm install my-harbor \
helm upgrade --install my-harbor \
    --namespace ${NAMESPACE} \
    --set harborAdminPassword="${HARBOR_ADMIN_PASSWORD}" \
    --set secretKey="${HARBOR_SECRET_KEY}" \
    --set registry.credentials.username="${REGISTRY_USERNAME}" \
    --set registry.credentials.password="${REGISTRY_PASSWORD}" \
    --set registry.credentials.htpasswd="${REGISTRY_HTPASSWD}" \
    --set database.internal.password="${INTERNAL_DATABASE_PASSWORD}" \
    --set database.external.username="${EXTERNAL_DATABASE_USERNAME}" \
    --set database.external.password="${EXTERNAL_DATABASE_PASSWORD}" \
    --set expose.ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set expose.ingress.hosts.core="core.harbor.example.com" \
    --set expose.ingress.hosts.notary="notary.harbor.example.com" \
    --set externalURL="https://core.harbor.example.com" \
    --set persistence.enabled="true" \
    --set persistence.persistentVolumeClaim.registry.storageClass="rook-ceph-block" \
    --set persistence.persistentVolumeClaim.chartmuseum.storageClass="rook-ceph-block" \
    --set persistence.persistentVolumeClaim.jobservice.storageClass="rook-ceph-block" \
    --set persistence.persistentVolumeClaim.database.storageClass="rook-ceph-block" \
    --set persistence.persistentVolumeClaim.redis.storageClass="rook-ceph-block" \
    --set persistence.persistentVolumeClaim.trivy.storageClass="rook-ceph-block" \
    --version 1.5.0 \
    harbor/harbor

    ### for s3 storage
    # --set persistence.imageChartStorage.type="s3" \
    # --set persistence.imageChartStorage.s3.region="us-west-1" \
    # --set persistence.imageChartStorage.s3.bucket="harbor-storage" \
    # --set persistence.imageChartStorage.s3.accesskey="${AWS_ACCESS_KEY}" \
    # --set persistence.imageChartStorage.s3.secretkey="${AWS_SECRET_KEY}" \
    # --set persistence.imageChartStorage.s3.regionendpoint="minio.example.com" \
    # --set persistence.imageChartStorage.s3.storageclass="rook-ceph-block" \

    ### for loadbalancer
    # --set expose.type="loadBalancer" \
    # --set expose.tls.commonName="core.harbor.example.com" \
    # --set expose.loadBalancer.IP="10.10.10.50" \
    # --set externalURL="core.harbor.example.com" \
