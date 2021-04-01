#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

bash ./set-instance-id.sh --instance=inst1 --port-offset=0
bash ./set-instance-id.sh --instance=inst2 --port-offset=1
