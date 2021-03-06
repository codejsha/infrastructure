#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

# bash ./add-access-log.sh
bash ./add-access-log.sh --port-offset=0
bash ./add-access-log.sh --port-offset=1

# bash ./set-logging.sh
bash ./set-logging.sh --port-offset=0
bash ./set-logging.sh --port-offset=1
