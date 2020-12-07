#!/bin/bash

git clone https://github.com/pinpoint-apm/pinpoint-kubernetes.git
# gh repo clone pinpoint-apm/pinpoint-kubernetes

NAMESPACE="pinpoint-system"

# helm install my-pinpoint \
helm upgrade --install my-pinpoint \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values values.yaml \
    ./pinpoint
