#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

######################################################################

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

    sudo yum install -y kubectl
    sudo yum install -y bash-completion
}

function install_kubectl_specific_version_with_yum {
    local KUBECTL_VERSION="1.18.8"

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

    sudo yum --showduplicate list kubectl
    sudo yum install -y kubectl-${KUBECTL_VERSION}
    sudo yum install -y bash-completion
}

function install_kubectl_with_download {
    local KUBECTL_VERSION="1.18.8"

    curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
    sudo chwon root:root /usr/local/bin/kubectl
}

function install_kubectl_with_apt {
    sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2 curl
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-get install -y kubectl
}

######################################################################

install_kubectl_with_yum
# install_kubectl_specific_version_with_yum
# install_kubectl_with_download
# install_kubectl_with_apt
