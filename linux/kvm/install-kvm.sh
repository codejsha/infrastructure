#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

sudo dnf module install -y virt
sudo dnf install -y virt-install virt-viewer libguestfs-tools

virt-host-validate

sudo systemctl start libvirtd.service
sudo systemctl enable libvirtd.service
