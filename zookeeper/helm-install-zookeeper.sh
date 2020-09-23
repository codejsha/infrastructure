#!/usr/bin/bash

NAMESPACE="zookeeper-system"
kubectl create namespace ${NAMESPACE}

# helm install my-zookeeper \
helm upgrade --install my-zookeeper \
    --namespace ${NAMESPACE} \
    incubator/zookeeper
