#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

# bash ./set-tcp-clustering.sh
# bash ./set-tcp-clustering.sh --instance=inst1 --port-offset=0
# bash ./set-tcp-clustering.sh --instance=inst2 --port-offset=1

# bash ./set-udp-clustering.sh
bash ./set-udp-clustering.sh --port-offset=0
bash ./set-udp-clustering.sh --port-offset=1

######################################################################

# bash ./set-clustering-stack.sh
# bash ./set-clustering-stack.sh --port-offset=0
# bash ./set-clustering-stack.sh --port-offset=1
bash ./set-clustering-stack.sh --port-offset=0 --stack-name=udp
bash ./set-clustering-stack.sh --port-offset=1 --stack-name=udp
# bash ./set-clustering-stack.sh --port-offset=0 --stack-name=tcp
# bash ./set-clustering-stack.sh --port-offset=1 --stack-name=tcp

######################################################################

# bash ./check-clustering.sh
bash ./check-clustering.sh --port-offset=0
bash ./check-clustering.sh --port-offset=1
