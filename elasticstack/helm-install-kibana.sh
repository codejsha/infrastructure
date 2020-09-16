#!/usr/bin/bash

NAMESPACE="elastic-system"
kubectl create namespace ${NAMESPACE}

# helm install my-kibana \
helm upgrade --install my-kibana \
    --namespace ${NAMESPACE} \
    --set resources.requests.cpu="100m" \
    --set resources.requests.memory="500m" \
    --set resources.limits.cpu="500m" \
    --set resources.limits.memory="1Gi" \
    --set ingress.enabled="true" \
    --set ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set ingress.hosts={"kibana.example.com"} \
    --set ingress.path="/" \
    --version 7.8.0 \
    elastic/kibana

    ### for loadbalancer
    # --set service.type="LoadBalancer" \
