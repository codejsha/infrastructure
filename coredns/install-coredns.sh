#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

COREDNS_VERSION="1.7.1"

curl -LJO https://github.com/coredns/coredns/releases/download/v${COREDNS_VERSION}/coredns_${COREDNS_VERSION}_linux_amd64.tgz
sudo mv coredns /usr/local/bin
sudo chown root:root /usr/local/bin/coredns

coredns -version
