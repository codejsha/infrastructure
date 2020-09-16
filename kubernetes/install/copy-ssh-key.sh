#!/usr/bin/bash

PASSWORD="changeit"
declare -A NODES=(
    [10.10.10.11]="controlplane1.example.com"
    [10.10.10.12]="controlplane2.example.com"
    [10.10.10.13]="controlplane3.example.com"
    [10.10.10.21]="node1.example.com"
    [10.10.10.22]="node2.example.com"
    [10.10.10.23]="node3.example.com"
)

rm --recursive --force ~/.ssh
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa

for ADDRESS in "${!NODES[@]}"
do
    ssh-keyscan -H ${ADDRESS},${NODES[$ADDRESS]} >> ~/.ssh/known_hosts
    sshpass -p "${PASSWORD}" ssh-copy-id -i ~/.ssh/id_rsa.pub root@${NODES[$ADDRESS]}
done
