#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

# bash ./set-tcp-clustering.sh
# bash ./set-tcp-clustering.sh --instance=inst1 --port-offset=0
# bash ./set-tcp-clustering.sh --instance=inst2 --port-offset=1

# bash ./set-ucp-clustering.sh
bash ./set-ucp-clustering.sh --port-offset=0
bash ./set-ucp-clustering.sh --port-offset=1

######################################################################

# bash ./check-clustering.sh
bash ./check-clustering.sh --port-offset=0
bash ./check-clustering.sh --port-offset=1
