#!/usr/bin/bash

helm repo add minio https://helm.min.io
helm repo update

PASSWORD="${PASSWORD}"

NAMESPACE="minio-system"
kubectl create namespace ${NAMESPACE}

# helm install my-minio \
helm upgrade --install my-minio \
    --namespace ${NAMESPACE} \
    --set accessKey="admin" \
    --set secretKey="${PASSWORD}" \
    --set service.type="LoadBalancer" \
    --set ingress.enabled="true" \
    --set ingress.labels."node-role\.kubernetes\.io/ingress"="platform" \
    --set ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set ingress.hosts={"minio.example.com"} \
    --set persistence.enabled="true" \
    --set persistence.storageClass="rook-ceph-block" \
    --set persistence.accessMode="ReadWriteOnce" \
    --version 7.0.1 \
    minio/minio
