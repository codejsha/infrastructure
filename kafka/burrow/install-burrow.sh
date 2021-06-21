#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

BURROW_VERSION="1.3.6"

curl -LJO https://github.com/linkedin/Burrow/releases/download/v${BURROW_VERSION}/Burrow_${BURROW_VERSION}_linux_amd64.tar.gz
tar -xzf Burrow_${BURROW_VERSION}_linux_amd64.tar.gz
sudo mv burrow /usr/local/bin
sudo chown root:root /usr/local/bin/burrow

rm -f Burrow_${BURROW_VERSION}_linux_amd64.tar.gz
