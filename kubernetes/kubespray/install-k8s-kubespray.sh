#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

PASSWORD="${PASSWORD}"

echo "${PASSWORD}" | sudo -S yum install -y python3-pip

# git clone -b release-2.15 https://github.com/kubernetes-sigs/kubespray.git
# gh repo clone kubernetes-sigs/kubespray.git -- -b release-2.15

curl -LJO https://github.com/kubernetes-sigs/kubespray/archive/refs/tags/v2.15.1.tar.gz
tar -xzf kubespray-2.15.1.tar.gz
mv kubespray-2.15.1 kubespray

cd kubespray
sudo pip3 install -r requirements.txt
/bin/cp -rpf inventory/sample inventory/mycluster

declare -a IPS=(192.168.140.11 192.168.140.12 192.168.140.13 192.168.140.21 192.168.140.22 192.168.140.23)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

/bin/cp -f ../config/hosts.yaml inventory/mycluster/hosts.yaml
/bin/cp -f ../config/all.yaml inventory/mycluster/group_vars/all/all.yml
/bin/cp -f ../config/docker.yaml inventory/mycluster/group_vars/all/docker.yml
/bin/cp -f ../config/addons.yaml inventory/mycluster/group_vars/k8s-cluster/addons.yml
/bin/cp -f ../config/k8s-cluster.yaml inventory/mycluster/group_vars/k8s-cluster/k8s-cluster.yml
/bin/cp -f ../config/k8s-net-calico.yaml inventory/mycluster/group_vars/k8s-cluster/k8s-net-calico.yml

ansible-playbook -i inventory/mycluster/hosts.yaml --become --become-user=root --user root cluster.yml
