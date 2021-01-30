#!/bin/bash

PASSWORD="${PASSWORD}"

echo "${PASSWORD}" | sudo -S yum install -y python3-pip
git clone -b release-2.15 https://github.com/kubernetes-sigs/kubespray.git
# gh repo clone kubernetes-sigs/kubespray.git -- -b release-2.15

cd kubespray
sudo pip3 install -r requirements.txt
/usr/bin/cp -rpf inventory/sample inventory/mycluster

declare -a IPS=(192.168.140.11 192.168.140.12 192.168.140.13 192.168.140.21 192.168.140.22 192.168.140.23)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

/usr/bin/cp -f ../hosts.yaml inventory/mycluster/hosts.yaml
/usr/bin/cp -f ../all.yaml inventory/mycluster/group_vars/all/all.yml
/usr/bin/cp -f ../docker.yaml inventory/mycluster/group_vars/all/docker.yml
/usr/bin/cp -f ../addons.yaml inventory/mycluster/group_vars/k8s-cluster/addons.yml
/usr/bin/cp -f ../k8s-cluster.yaml inventory/mycluster/group_vars/k8s-cluster/k8s-cluster.yml
/usr/bin/cp -f ../k8s-net-calico.yaml inventory/mycluster/group_vars/k8s-cluster/k8s-net-calico.yml

ansible-playbook -i inventory/mycluster/hosts.yaml --become --become-user=root --user root cluster.yml
