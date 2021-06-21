#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

crc delete
crc cleanup
crc setup
./crc start --pull-secret-file ~/pull-secret.txt
