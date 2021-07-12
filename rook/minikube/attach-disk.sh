#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

UUID="$(uuidgen)"
IMAGE="/var/lib/libvirt/images/minikube-${UUID}"
sudo qemu-img create -f raw ${IMAGE} 100G
sudo virsh attach-disk minikube ${IMAGE} vdb --cache none --persistent

UUID="$(uuidgen)"
IMAGE="/var/lib/libvirt/images/minikube-${UUID}"
sudo qemu-img create -f raw ${IMAGE} 100G
sudo virsh attach-disk minikube ${IMAGE} vdc --cache none --persistent

UUID="$(uuidgen)"
IMAGE="/var/lib/libvirt/images/minikube-${UUID}"
sudo qemu-img create -f raw ${IMAGE} 100G
sudo virsh attach-disk minikube ${IMAGE} vdd --cache none --persistent
