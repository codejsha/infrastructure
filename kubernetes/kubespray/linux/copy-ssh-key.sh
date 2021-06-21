#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

PASSWORD="${PASSWORD}"
declare -A NODES=(
    [controlplane1]="192.168.140.11"
    [controlplane2]="192.168.140.12"
    [controlplane3]="192.168.140.13"
    [node1]="192.168.140.21"
    [node2]="192.168.140.22"
    [node3]="192.168.140.23"
)

rm --force ~/.ssh/id_rsa
rm --force ~/.ssh/id_rsa.pub
rm --force ~/.ssh/known_hosts
# rm --force ~/.ssh/authorized_keys

ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa

for NODE_NAME in "${!NODES[@]}"
do
    ssh-keyscan -H ${NODES[${NODE_NAME}]},${NODE_NAME} >> ~/.ssh/known_hosts
    sshpass -p ${PASSWORD} ssh-copy-id -i ~/.ssh/id_rsa.pub root@${NODES[${NODE_NAME}]}
    # sshpass -p ${PASSWORD} ssh-copy-id -i ~/.ssh/id_rsa.pub prouser@${NODES[${NODE_NAME}]}
done
