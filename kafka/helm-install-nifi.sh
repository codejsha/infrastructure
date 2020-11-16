#!/usr/bin/bash

helm repo add cetic https://cetic.github.io/helm-charts
helm repo update

NAMESPACE="kafka-system"
kubectl create namespace ${NAMESPACE}

# helm install my-nifi \
helm upgrade --install my-nifi \
    --namespace ${NAMESPACE} \
    --set jvmMemory="1g" \
    --set zookeeper.enabled="false" \
    --set zookeeper.url="zookeeper.example.com" \
    --set service.type="ClusterIP" \
    --set ingress.enabled="true" \
    --set ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set ingress.hosts={"nifi.example.com"} \
    --set ingress.path="/" \
    --set persistence.enabled="true" \
    --set persistence.storageClass="rook-ceph-block" \
    --set registry.enabled="true" \
    --set registry.persistence.enabled="true" \
    --set registry.persistence.database.storageClass="rook-ceph-block" \
    --set registry.persistence.flowStorage.storageClass="rook-ceph-block" \
    --version 0.6.0 \
    cetic/nifi

    ### for loadbalancer
    # --set service.loadBalancerIP="10.10.10.50" \
