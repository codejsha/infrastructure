#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

crc delete
crc cleanup
crc setup
./crc start --pull-secret-file ~/pull-secret.txt
