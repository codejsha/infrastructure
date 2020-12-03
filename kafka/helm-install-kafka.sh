#!/bin/bash

NAMESPACE="kafka-system"

# helm install my-kafka \
helm upgrade --install my-kafka \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set replicaCount="3" \
    --set persistence.enabled="true" \
    --set persistence.storageClass="rook-ceph-block" \
    --set zookeeper.replicaCount="3" \
    --set zookeeper.persistence.enabled="true" \
    --set zookeeper.persistence.storageClass="rook-ceph-block" \
    --values kafka-values.yaml \
    --version 12.1.0 \
    bitnami/kafka
