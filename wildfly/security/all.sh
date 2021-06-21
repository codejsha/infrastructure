#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

bash ./disable-directory-index.sh --port-offset=0
bash ./disable-directory-index.sh --port-offset=1
