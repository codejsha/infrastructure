#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

sudo tcpdump -ni eth0 host 228.0.0.4
sudo tcpdump -ni eth0 tcp port 4000
