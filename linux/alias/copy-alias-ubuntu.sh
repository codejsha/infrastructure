#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

rm -rf ~/.aliases

/bin/cp -f .bashrc_ubuntu ~/.bashrc
/bin/cp -rf aliases ~/.aliases

curl -o ~/.aliases/kubectl_aliases -LJO https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases
