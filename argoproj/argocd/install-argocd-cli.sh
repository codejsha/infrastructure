#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
# set -o xtrace

ARGOCD_VERSION="v1.8.1"

sudo curl -o /usr/local/bin/argocd -LJO https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_VERSION}/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd

argocd version
