#!/usr/bin/bash

NAMESPACE="chart-system"
kubectl create namespace ${NAMESPACE}

# helm install my-chartmuseum \
helm upgrade --install my-chartmuseum \
    --namespace ${NAMESPACE} \
    --set env.open.DISABLE_API="false" \
    --set ingress.enabled="true" \
    --set ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set ingress.hosts[0].name="chartmuseum.example.com" \
    --set ingress.hosts[0].path="/" \
    --set ingress.hosts[0].tls="false" \
    --set persistence.enabled="true" \
    --set persistence.storageClass="rook-ceph-block" \
    --version 2.13.1 \
    --values override.yaml \
    stable/chartmuseum

### repo add
# helm repo add chartmuseum http://chartmuseum.example.com
### health check
# curl --insecure --verbose http://chartmuseum.example.com/health
