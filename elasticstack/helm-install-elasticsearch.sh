#!/bin/bash

helm repo add elastic https://helm.elastic.co
helm repo update

NAMESPACE="elastic-system"

helm upgrade --install my-elasticsearch \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set esJavaOpts="-Xms512m -Xmx512m" \
    --set volumeClaimTemplate.storageClassName="rook-ceph-block" \
    --version 7.8.0 \
    elastic/elasticsearch
