#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

OCTANT_VERSION="0.18.0"

curl -LJO https://github.com/vmware-tanzu/octant/releases/download/v${OCTANT_VERSION}/octant_${OCTANT_VERSION}_Linux-64bit.tar.gz
tar -xzf octant_${OCTANT_VERSION}_Linux-64bit.tar.gz
sudo mv octant_${OCTANT_VERSION}_Linux-64bit/octant /usr/local/bin
sudo chown root:root /usr/local/bin/octant

rm -rf octant_${OCTANT_VERSION}_Linux-64bit octant_${OCTANT_VERSION}_Linux-64bit.tar.gz
