#!/usr/bin/bash

PASSWORD="${PASSWORD}"
declare -A NODES=(
    [10.10.10.11]="controlplane1"
    [10.10.10.12]="controlplane2"
    [10.10.10.13]="controlplane3"
    [10.10.10.21]="node1"
    [10.10.10.22]="node2"
    [10.10.10.23]="node3"
)

rm --force ~/.ssh/id_rsa
rm --force ~/.ssh/id_rsa.pub
rm --force ~/.ssh/known_hosts
# rm --force ~/.ssh/authorized_keys

ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa

for ADDRESS in "${!NODES[@]}"
do
    ssh-keyscan -H ${ADDRESS},${NODES[$ADDRESS]} >> ~/.ssh/known_hosts
    sshpass -p "${PASSWORD}" ssh-copy-id -i ~/.ssh/id_rsa.pub root@${NODES[$ADDRESS]}
done
