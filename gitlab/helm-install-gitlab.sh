#!/usr/bin/bash
# https://docs.gitlab.com/charts
# https://gitlab.com/gitlab-org/charts/gitlab

helm repo add gitlab https://charts.gitlab.io
helm repo update

NAMESPACE="gitlab-system"
kubectl create namespace ${NAMESPACE}

# helm install my-gitlab \
helm upgrade --install my-gitlab \
    --namespace ${NAMESPACE} \
    --set global.edition="ce" \
    --version 4.2.1 \
    gitlab/gitlab
