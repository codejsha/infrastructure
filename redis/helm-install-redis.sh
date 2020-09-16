#!/usr/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

PASSWORD="changeit"

NAMESPACE="redis-system"
kubectl create namespace ${NAMESPACE}

# helm install my-redis \
helm upgrade --install my-redis \
    --namespace ${NAMESPACE} \
    --set password="${PASSWORD}" \
    --set ingress.enabled="true" \
    --set ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set ingress.name={"redis.example.com"} \
    --set ingress.path="/" \
    --set master.persistence.enabled="true" \
    --set master.persistence.storageClass="rook-ceph-block" \
    --set slave.persistence.enabled="true" \
    --set slave.persistence.storageClass="rook-ceph-block" \
    --version 10.8.1 \
    bitnami/redis
