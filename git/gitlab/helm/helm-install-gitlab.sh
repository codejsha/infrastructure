#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

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
