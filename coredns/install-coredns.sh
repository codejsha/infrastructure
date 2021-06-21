#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

COREDNS_VERSION="1.8.3"

curl -LJO https://github.com/coredns/coredns/releases/download/v${COREDNS_VERSION}/coredns_${COREDNS_VERSION}_linux_amd64.tgz
sudo mv coredns /usr/local/bin
sudo chown root:root /usr/local/bin/coredns

coredns -version
