#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

mkdir -p ${HOME}/.kube
sudo scp root@controlplane1:/root/.kube/config ${HOME}/.kube/config
sudo chown -R $(id -un):$(id -gn) ${HOME}/.kube/config

sudo mkdir -p /etc/ssl/etcd/ssl/
sudo scp root@controlplane1:/etc/ssl/etcd/ssl/* /etc/ssl/etcd/ssl/
sudo chown -R root:$(id -gn) /etc/ssl/etcd/ssl/
