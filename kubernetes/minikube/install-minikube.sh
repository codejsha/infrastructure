#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

### requirement:
### - SELinux permissive

### kvm
# sudo dnf module install -y virt
# sudo dnf install -y virt-install virt-viewer libguestfs-tools
# sudo dnf install -y qemu-kvm

### install
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm -f minikube-linux-amd64

# sudo dnf install -y conntrack
# sudo dnf install -y socat
