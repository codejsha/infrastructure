#!/bin/bash

sudo sysctl -w vm.max_map_count=262144
sudo echo "vm.max_map_count=262144" >> /etc/sysctl.conf
