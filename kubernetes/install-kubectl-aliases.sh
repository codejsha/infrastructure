#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

curl -o ~/.aliases/.kubectl_aliases -LJO https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases

# function kubectl() { echo "+ kubectl ${@}">&2; command kubectl ${@}; }
# [ -f ~/.aliases/.kubectl_aliases ] && source ~/.aliases/.kubectl_aliases
