#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

NAMESPACE="elastic-system"

# helm install my-kibana \
helm upgrade --install my-kibana \
    --create-namespace \
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
