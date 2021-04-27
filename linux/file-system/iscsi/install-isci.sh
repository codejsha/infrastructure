#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

sudo yum install -y targetcli
sudo yum install -y iscsi-initiator-utils

sudo systemctl start target
sudo systemctl enable target

# sudo firewall-cmd --permanent --add-port=3260/tcp
# sudo firewall-cmd --reload
