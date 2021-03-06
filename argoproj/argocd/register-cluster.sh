#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
# set -o xtrace

# argocd cluster list
# argocd cluster get argocd https://10.10.10.11:6443
# argocd cluster add
argocd cluster add kubernetes-admin@cluster.local
