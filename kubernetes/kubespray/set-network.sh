#!/bin/bash

declare -A NODES=(
    [10.10.10.10]="kubeaccess"
    [10.10.10.11]="controlplane1"
    [10.10.10.12]="controlplane2"
    [10.10.10.13]="controlplane3"
    [10.10.10.21]="node1"
    [10.10.10.22]="node2"
    [10.10.10.23]="node3"
)

for ADDRESS in "${!NODES[@]}"
do
    if [ "$(hostname)" == "${NODES[$ADDRESS]}" ]; then
        nmcli connection delete eth0
        nmcli connection delete "Wired connection 1"
        nmcli connection add type ethernet con-name eth0 ifname eth0
        nmcli connection modify eth0 ipv4.addresses ${ADDRESS}/24
        nmcli connection modify eth1 ipv4.gateway 10.10.10.1
        nmcli connection modify eth0 ipv4.method manual
        nmcli connection modify eth0 ipv6.ip6-privacy 0
        nmcli connection modify eth0 ipv4.dns "10.10.10.10,8.8.8.8,168.126.63.1"
        exit
    fi
done

systemctl restart NetworkManager

# declare -A NODES=(
#     [10.10.10.10]="kubeaccess"
#     [10.10.10.11]="controlplane1"
#     [10.10.10.12]="controlplane2"
#     [10.10.10.13]="controlplane3"
#     [10.10.10.21]="node1"
#     [10.10.10.22]="node2"
#     [10.10.10.23]="node3"
# )
#
# for ADDRESS in "${!NODES[@]}"
# do
#     if [ "$(hostname)" == "${NODES[$ADDRESS]}" ]; then
#         nmcli connection delete eth0
#         nmcli connection delete "Wired connection 1"
#         nmcli connection add type ethernet con-name eth0 ifname eth0
#         nmcli connection modify eth0 ipv4.addresses ${ADDRESS}/24
#         nmcli connection modify eth0 ipv4.method manual
#         nmcli connection modify eth0 ipv6.ip6-privacy 0
#         break
#     fi
# done
#
# declare -A INT_NODES=(
#     [192.168.137.10]="kubeaccess"
#     [192.168.137.11]="controlplane1"
#     [192.168.137.12]="controlplane2"
#     [192.168.137.13]="controlplane3"
#     [192.168.137.21]="node1"
#     [192.168.137.22]="node2"
#     [192.168.137.23]="node3"
# )
#
# for INT_ADDRESS in "${!INT_NODES[@]}"
# do
#     if [ "$(hostname)" == "${INT_NODES[$INT_ADDRESS]}" ]; then
#         nmcli connection delete eth1
#         nmcli connection delete "Wired connection 1"
#         nmcli connection add type ethernet con-name eth1 ifname eth1
#         nmcli connection modify eth1 ipv4.addresses ${INT_ADDRESS}/24
#         nmcli connection modify eth1 ipv4.gateway 192.168.137.1
#         nmcli connection modify eth1 ipv4.method manual
#         nmcli connection modify eth1 ipv6.ip6-privacy 0
#         nmcli connection modify eth1 ipv4.dns "10.10.10.10,8.8.8.8,168.126.63.1"
#         break
#     fi
# done
#
# nmcli connection modify eth0 ipv4.dns-priority 100
# nmcli connection modify eth1 ipv4.dns-priority 110
# nmcli connection modify eth0 ipv4.route-metric 100
# nmcli connection modify eth1 ipv4.route-metric 110
#
# systemctl restart NetworkManager
