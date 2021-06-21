#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

PROJECT="myproject"
SERVER="*"
NAMESPACE="*"
URL="*"
GROUP="*"
KIND="*"

argocd proj create ${PROJECT}
argocd proj add-destination ${PROJECT} ${SERVER} ${NAMESPACE}
argocd proj add-source ${PROJECT} ${URL}
argocd proj allow-cluster-resource ${PROJECT} ${GROUP} ${KIND}
