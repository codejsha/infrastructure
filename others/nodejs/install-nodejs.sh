#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

### As root
# curl -sL https://rpm.nodesource.com/setup_lts.x | bash -
### No root privileges
curl -sL https://rpm.nodesource.com/setup_lts.x | sudo bash -

sudo yum remove -y nodejs npm
sudo yum install -y nodejs

### to build native addons
# sudo yum install -y gcc-c++ make
