#!/bin/bash

helm repo add minio https://helm.min.io
helm repo update

PASSWORD="${PASSWORD}"

NAMESPACE="minio-system"

# helm install my-minio \
helm upgrade --install my-minio \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set accessKey="admin" \
    --set secretKey="${PASSWORD}" \
    --set service.type="ClusterIP" \
    --set ingress.enabled="true" \
    --set ingress.labels."node-role\.kubernetes\.io/ingress"="platform" \
    --set ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set-string ingress.annotations."nginx\.ingress\.kubernetes\.io/proxy-body-size"="0" \
    --set ingress.hosts={"minio.example.com"} \
    --set persistence.enabled="true" \
    --set persistence.storageClass="rook-ceph-block" \
    --set persistence.accessMode="ReadWriteOnce" \
    --version 7.0.1 \
    minio/minio

    ### for loadbalancer
    # --set service.type="LoadBalancer" \
