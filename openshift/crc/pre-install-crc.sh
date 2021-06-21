#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

### firewall
systemctl disable firewalld
systemctl stop firewalld

### sudoers
sed -i -E '/^root\tALL=\(ALL\) \tALL$/ a prouser\tALL=(ALL) \tNOPASSWD:ALL' /etc/sudoers

### selinux
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

### podman
yum install -y podman
# podman login --username ${USERNAME} --password ${PASSWORD} https://registry.redhat.io/v2/
