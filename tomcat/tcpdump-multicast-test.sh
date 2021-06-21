#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

sudo tcpdump -ni eth0 host 228.0.0.4
sudo tcpdump -ni eth0 tcp port 4000
