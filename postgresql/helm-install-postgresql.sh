#!/usr/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

PASSWORD="${PASSWORD}"

NAMESPACE="postgres-system"

# helm install my-postgres \
helm upgrade --install my-postgres \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set postgresqlUsername="postgres" \
    --set postgresqlPassword="${PASSWORD}" \
    --set service.type="LoadBalancer" \
    --set service.loadBalancerIP="10.10.10.99" \
    --set persistence.enabled="true" \
    --set persistence.storageClass="rook-ceph-block" \
    --version 9.8.3 \
    bitnami/postgresql

    ### gitlab
    # --values gitlab-values.yaml \
