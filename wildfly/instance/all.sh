#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

# bash ./create-instance.sh
bash ./create-instance.sh --instance=inst1
bash ./create-instance.sh --instance=inst2

# bash create-scripts.sh
bash ./create-scripts.sh --instance=inst1 --port-offset=0
bash ./create-scripts.sh --instance=inst2 --port-offset=1
