#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

rm -rf ~/.aliases

/bin/cp -f .bashrc ~/.bashrc
/bin/cp -rf aliases ~/.aliases

curl -o ~/.aliases/kubectl_aliases -LJO https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases
