#!/usr/bin/bash

if [ "${1}" == "a" ]; then
    hostnamectl set-hostname kubeaccess
elif [ "${1}" == "c1" ]; then
    hostnamectl set-hostname kubecontrolplane1
elif [ "${1}" == "c2" ]; then
    hostnamectl set-hostname kubecontrolplane2
elif [ "${1}" == "c3" ]; then
    hostnamectl set-hostname kubecontrolplane3
elif [ "${1}" == "n1" ]; then
    hostnamectl set-hostname kubenode1
elif [ "${1}" == "n2" ]; then
    hostnamectl set-hostname kubenode2
elif [ "${1}" == "n3" ]; then
    hostnamectl set-hostname kubenode3
fi
