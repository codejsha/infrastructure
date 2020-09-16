#!/usr/bin/bash

NAMESPACE="tomcat-system"
kubectl create namespace ${NAMESPACE}
kubectl label namespace ${NAMESPACE} istio-injection=enabled

# helm install my-tomcat \
helm upgrade --install my-tomcat \
    --namespace ${NAMESPACE} \
    --set ingress.enabled="true" \
    --set ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set ingress.hosts[0].name="tomcat.example.com" \
    --set ingress.hosts[0].path="/" \
    --set persistence.enabled="true" \
    --set persistence.storageClass="rook-ceph-block" \
    --version 6.3.10 \
    bitnami/tomcat

    ### custom image
    # --set image.registry="nexus.example.com/repository/docker-public"
    # --set image.repository="tomcat"
    # --set image.tag="latest"

    ### for loadbalancer
    # --set service.loadBalancerIP="10.10.10.50" \
