#!/bin/bash

helm repo add confluentinc https://confluentinc.github.io/cp-helm-charts
helm repo update

NAMESPACE="kafka-system"

# helm install my-cp-kafka \
helm upgrade --install my-cp-kafka \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set cp-zookeeper.persistence.dataDirStorageClass="standard" \
    --set cp-zookeeper.persistence.dataLogDirStorageClass="standard" \
    --set cp-kafka.persistence.storageClass="standard" \
    --version 0.5.0 \
    confluentinc/cp-helm-charts

    ### rook ceph
    # --set cp-zookeeper.persistence.dataDirStorageClass="rook-ceph-block" \
    # --set cp-zookeeper.persistence.dataLogDirStorageClass="rook-ceph-block" \
    # --set cp-kafka.persistence.storageClass="rook-ceph-block" \

    ### local path provisioner
    # --set cp-zookeeper.persistence.dataDirStorageClass="local-path" \
    # --set cp-zookeeper.persistence.dataLogDirStorageClass="local-path" \
    # --set cp-kafka.persistence.storageClass="local-path" \
