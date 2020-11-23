#!/bin/bash

NAMESPACE="zookeeper-system"

# helm install my-zookeeper \
helm upgrade --install my-zookeeper \
    --create-namespace \
    --namespace ${NAMESPACE} \
    incubator/zookeeper
