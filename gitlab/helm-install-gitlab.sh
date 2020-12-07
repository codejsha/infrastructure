#!/bin/bash

helm repo add gitlab https://charts.gitlab.io
helm repo update

NAMESPACE="gitlab-system"

# helm install my-gitlab \
helm upgrade --install my-gitlab \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set global.edition="ce" \
    --version 4.2.1 \
    gitlab/gitlab
