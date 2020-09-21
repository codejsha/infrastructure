#!/usr/bin/bash

USERNAME="prouser"

sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io

sudo usermod -a -G docker ${USERNAME}
sudo systemctl enable docker
sudo systemctl start docker

# sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
# sudo dnf install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.10-3.2.el7.x86_64.rpm
# sudo dnf install -y docker-ce
#
# sudo usermod -a -G docker ${USERNAME}
# sudo systemctl enable --now docker
# sudo systemctl status docker
