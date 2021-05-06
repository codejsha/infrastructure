#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

helm repo add descheduler https://kubernetes-sigs.github.io/descheduler
helm repo update

# helm install my-descheduler \
helm upgrade --install my-descheduler \
    --version 0.19.1 \
    descheduler/descheduler-helm-chart

    # --values helm-chart-values.yaml \
