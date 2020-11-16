#!/usr/bin/bash

NAMESPACE="kafka-system"

# helm install my-kafka \
helm upgrade --install my-kafka \
    --create-namespace
    --namespace ${NAMESPACE} \
    --set persistence.enabled="true" \
    --set persistence.storageClass="rook-ceph-block" \
    --set zookeeper.persistence.enabled="true" \
    --set zookeeper.persistence.storageClass="rook-ceph-block" \
    --version 0.21.2 \
    incubator/kafka

### confluent kafka chart
# helm repo add confluentinc https://confluentinc.github.io/cp-helm-charts
# helm repo update
# helm install my-kafka \
#     --set cp-zookeeper.persistence.dataDirStorageClass="rook-ceph-block" \
#     --set cp-zookeeper.persistence.dataLogDirStorageClass="rook-ceph-block" \
#     --set cp-kafka.persistence.storageClass="rook-ceph-block" \
#     --version 0.5.0 \
#     confluentinc/cp-helm-charts
