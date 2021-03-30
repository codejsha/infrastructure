#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

sudo yum install -y epel-release
sudo yum install -y sshpass

cat <<EOF | sudo tee -a /etc/hosts
192.168.140.10 kubeaccess
192.168.140.11 controlplane1
192.168.140.12 controlplane2
192.168.140.13 controlplane3
192.168.140.21 node1
192.168.140.22 node2
192.168.140.23 node3
EOF
