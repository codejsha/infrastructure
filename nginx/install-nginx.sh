#!/bin/bash
# https://www.nginx.com/resources/wiki/start/topics/tutorials/install

cat > /etc/yum.repos.d/nginx.repo <<EOF 
[nginx]
name=nginx repo
baseurl=https://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=0
enabled=1
EOF

sudo yum install -y nginx
