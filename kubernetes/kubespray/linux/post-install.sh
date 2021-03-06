#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

mkdir -p ${HOME}/.kube
sudo scp root@controlplane1:/root/.kube/config ${HOME}/.kube/config
sudo chown -R $(id -un):$(id -gn) ${HOME}/.kube/config

sudo mkdir -p /etc/ssl/etcd/ssl/
sudo scp root@controlplane1:/etc/ssl/etcd/ssl/* /etc/ssl/etcd/ssl/
sudo chown -R root:$(id -gn) /etc/ssl/etcd/ssl/
