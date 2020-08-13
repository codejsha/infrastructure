#!/usr/bin/bash
# https://kubernetes.io/docs/tasks/tools/install-kubectl

### Install kubectl binary with curl on Linux
# curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.17.8/bin/linux/amd64/kubectl
# chmod +x ./kubectl
# sudo mv ./kubectl /usr/local/bin/kubectl

### Install using native package management
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
# sudo yum --showduplicate list kubectl
sudo yum install -y kubectl-1.17.8