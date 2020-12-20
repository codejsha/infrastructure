#!/bin/bash

helm repo add descheduler https://kubernetes-sigs.github.io/descheduler
helm repo update

# helm install my-descheduler \
helm upgrade --install my-descheduler \
    descheduler/descheduler-helm-chart

    # --values chart-values.yaml \
    # --version 0.19.0 \
