#!/usr/bin/bash

sudo yum install -y cockpit
sudo firewall-cmd --permanent --zone=public --add-service=cockpit
sudo firewall-cmd --reload

# curl --insecure --include https://test.example.com:9090
# curl -ki https://test.example.com:9090
