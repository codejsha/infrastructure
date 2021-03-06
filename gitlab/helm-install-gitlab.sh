#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

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
