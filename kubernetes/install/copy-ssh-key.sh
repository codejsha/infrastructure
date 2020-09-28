#!/usr/bin/bash

PASSWORD="${PASSWORD}"
declare -A NODES=(
    [10.10.10.11]="kubecontrolplane1"
    [10.10.10.12]="kubecontrolplane2"
    [10.10.10.13]="kubecontrolplane3"
    [10.10.10.21]="kubenode1"
    [10.10.10.22]="kubenode2"
    [10.10.10.23]="kubenode3"
)

rm --recursive --force ~/.ssh
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa

for ADDRESS in "${!NODES[@]}"
do
    ssh-keyscan -H ${ADDRESS},${NODES[$ADDRESS]} >> ~/.ssh/known_hosts
    sshpass -p "${PASSWORD}" ssh-copy-id -i ~/.ssh/id_rsa.pub root@${NODES[$ADDRESS]}
done
