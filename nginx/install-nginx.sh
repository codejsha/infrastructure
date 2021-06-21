#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

cat <<EOF | sudo tee /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=https://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOF

sudo yum install -y nginx

sudo systemctl enable nginx
sudo systemctl start nginx

# sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
# sudo firewall-cmd --reload
