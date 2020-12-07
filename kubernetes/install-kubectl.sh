#!/bin/bash

KUBECTL_VERSION="1.18.8"

######################################################################

function install_kubectl_with_download {
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
}

function install_kubectl_with_yum {
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

    # sudo yum --showduplicate list kubectl
    sudo yum install -y kubectl-${KUBECTL_VERSION}
    sudo yum install -y bash-completion
}

######################################################################

# install_kubectl_with_download
install_kubectl_with_yum
