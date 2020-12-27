#!/bin/bash

NAMESPACE="tomcat-system"
kubectl create namespace ${NAMESPACE}
kubectl label namespace ${NAMESPACE} istio-injection=enabled

# helm install my-tomcat \
helm upgrade --install my-tomcat \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values chart-values.yaml \
    --version 8.0.0 \
    bitnami/tomcat
