#!/bin/bash

NAMESPACE="kafka-system"

helm repo add strimzi https://strimzi.io/charts
helm repo update

# helm install my-kafka-operator \
helm upgrade --install my-kafka-operator \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --version 0.20.1 \
    strimzi/strimzi-kafka-operator

    # --values helm-chart-values-strimzi.yaml \

kubectl apply --filename strimzi-kafka-cluster.yaml
