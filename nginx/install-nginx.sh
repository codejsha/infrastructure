#!/bin/bash

cat > /etc/yum.repos.d/nginx.repo <<EOF 
[nginx]
name=nginx repo
baseurl=https://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=0
enabled=1
EOF

sudo yum install -y nginx
