#!/usr/bin/bash

PASSWORD="changeit"

git clone -b release-2.13 https://github.com/kubernetes-sigs/kubespray.git

echo "${PASSWORD}" | sudo -S yum install -y python3-pip
pip3 install -r requirements.txt

cd kubespray
/bin/cp -rpf inventory/sample inventory/mycluster

declare -a IPS=(10.10.10.11 10.10.10.12 10.10.10.13 10.10.10.21 10.10.10.22 10.10.10.23)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

cat inventory/mycluster/group_vars/all/all.yml
cat inventory/mycluster/group_vars/k8s-cluster/k8s-cluster.yml

cp ../hosts.yaml inventory/mycluster/hosts.yaml
ansible-playbook -i inventory/mycluster/hosts.yaml --become --become-user=root --user root cluster.yml
