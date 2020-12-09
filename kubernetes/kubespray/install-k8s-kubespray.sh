#!/bin/bash

PASSWORD="${PASSWORD}"

echo "${PASSWORD}" | sudo -S yum install -y python3-pip
git clone -b release-2.14 https://github.com/kubernetes-sigs/kubespray.git

cd kubespray
sudo pip3 install -r requirements.txt
/usr/bin/cp -rpf inventory/sample inventory/mycluster

declare -a IPS=(10.10.10.11 10.10.10.12 10.10.10.13 10.10.10.21 10.10.10.22 10.10.10.23)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

/usr/bin/cp -f ../hosts.yaml inventory/mycluster/hosts.yaml
/usr/bin/cp -f ../all.yaml inventory/mycluster/group_vars/all/all.yml
/usr/bin/cp -f ../docker.yaml inventory/mycluster/group_vars/all/docker.yml
/usr/bin/cp -f ../addons.yaml inventory/mycluster/group_vars/k8s-cluster/addons.yml
/usr/bin/cp -f ../k8s-cluster.yaml inventory/mycluster/group_vars/k8s-cluster/k8s-cluster.yml

ansible-playbook -i inventory/mycluster/hosts.yaml --become --become-user=root --user root cluster.yml
