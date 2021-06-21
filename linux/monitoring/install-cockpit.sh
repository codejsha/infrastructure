#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

sudo yum install -y cockpit
sudo yum install -y cockpit-networkmanager
sudo yum install -y cockpit-packagekit
sudo yum install -y cockpit-storaged
sudo yum install -y cockpit-pcp

sudo yum install -y cockpit-dashboard

sudo yum install -y cockpit-machines
sudo yum install -y cockpit-podman

sudo systemctl enable cockpit.socket
sudo systemctl start cockpit.socket
sudo systemctl start cockpit.service

sudo systemctl enable pmcd
sudo systemctl start pmcd
sudo systemctl enable pmlogger
sudo systemctl start pmlogger

sudo firewall-cmd --permanent --zone=public --add-service=cockpit
sudo firewall-cmd --reload

# curl --insecure --include https://test.example.com:9090
# curl -ki https://test.example.com:9090
