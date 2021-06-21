#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

# kustomize build ./base | kubectl apply --filename -
# kustomize build ./overlays/development | kubectl apply --filename -
# kustomize build ./overlays/production | kubectl apply --filename -

kustomize build https://github.com/codejsha/infrastructure/tree/main/tomcat/kustomize/base | kubectl apply --filename -
# kustomize build https://github.com/codejsha/infrastructure/tree/main/tomcat/kustomize/overlays/development | kubectl apply --filename -
# kustomize build https://github.com/codejsha/infrastructure/tree/main/tomcat/kustomize/overlays/production | kubectl apply --filename -
