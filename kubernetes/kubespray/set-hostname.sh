#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

if [ "${1}" == "a" ]; then
    hostnamectl set-hostname kubeaccess
elif [ "${1}" == "c1" ]; then
    hostnamectl set-hostname controlplane1
elif [ "${1}" == "c2" ]; then
    hostnamectl set-hostname controlplane2
elif [ "${1}" == "c3" ]; then
    hostnamectl set-hostname controlplane3
elif [ "${1}" == "n1" ]; then
    hostnamectl set-hostname node1
elif [ "${1}" == "n2" ]; then
    hostnamectl set-hostname node2
elif [ "${1}" == "n3" ]; then
    hostnamectl set-hostname node3
fi
