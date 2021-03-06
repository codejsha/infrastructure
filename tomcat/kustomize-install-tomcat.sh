#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

# kustomize build ./kustomize/base | kubectl apply --filename -

kustomize build https://github.com/codejsha/infrastructure/tree/main/tomcat/kustomize/base | kubectl apply --filename -
# kustomize build https://github.com/codejsha/infrastructure/tree/main/tomcat/kustomize/overlays/development | kubectl apply --filename -
# kustomize build https://github.com/codejsha/infrastructure/tree/main/tomcat/kustomize/overlays/production | kubectl apply --filename -
