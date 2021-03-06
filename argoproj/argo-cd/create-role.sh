#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

PROJECT="myproject"
APP="myproject"
ROLE_NAME="my-role"

argocd proj role create ${PROJECT} ${ROLE_NAME}
argocd proj role list ${PROJECT}
argocd proj role get ${PROJECT} ${ROLE_NAME}

# argocd proj role create-token ${PROJECT} ${ROLE_NAME}
# argocd proj role create-token ${PROJECT} ${ROLE_NAME} --expires-in 3h
JWT_TOKEN=$(argocd proj role create-token ${PROJECT} ${ROLE_NAME})
echo ${JWT_TOKEN}

argocd proj role add-policy ${PROJECT} ${ROLE_NAME} --action get --permission allow --object ${APP}
argocd proj role add-policy ${PROJECT} ${ROLE_NAME} --action sync --permission allow --object ${APP}
argocd app get ${PROJECT} ${ROLE_NAME} --auth-token ${JWT_TOKEN}
