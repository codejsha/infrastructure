#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

# argocd cluster list
# argocd cluster get argocd https://10.10.10.11:6443
# argocd cluster add
argocd cluster add kubernetes-admin@cluster.local
