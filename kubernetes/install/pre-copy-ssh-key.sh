#!/usr/bin/bash

sudo yum install -y epel-release sshpass

cat <<EOF | sudo tee -a /etc/hosts
10.10.10.10 kubeaccess
10.10.10.11 controlplane1
10.10.10.12 controlplane2
10.10.10.13 controlplane3
10.10.10.21 node1
10.10.10.22 node2
10.10.10.23 node3
EOF
