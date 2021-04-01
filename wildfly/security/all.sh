#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

bash ./disable-directory-index.sh --port-offset=0
bash ./disable-directory-index.sh --port-offset=1
