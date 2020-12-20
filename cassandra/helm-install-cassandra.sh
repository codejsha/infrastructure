#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

NAMESPACE="cassandra-system"

# helm install my-cassandra \
helm upgrade --install my-cassandra \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values chart-values.yaml \
    --version 7.1.2 \
    bitnami/cassandra
