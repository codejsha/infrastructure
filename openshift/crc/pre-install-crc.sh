#!/bin/bash

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