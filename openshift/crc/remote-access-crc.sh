#!/bin/bash

sudo dnf install -y haproxy policycoreutils-python-utils jq

sudo systemctl stop firewalld

### for firewall
# sudo systemctl start firewalld
# sudo firewall-cmd --add-port=80/tcp --permanent
# sudo firewall-cmd --add-port=6443/tcp --permanent
# sudo firewall-cmd --add-port=443/tcp --permanent
# sudo systemctl restart firewalld

### for selinux
# sudo semanage port -a -t http_port_t -p tcp 6443

sudo cp /etc/haproxy/haproxy.cfg{,_backup}

CRC_IP=$(crc ip)
sudo tee /etc/haproxy/haproxy.cfg &>/dev/null <<EOF
global
    debug

defaults
    log global
    mode http
    timeout connect 5000
    timeout client 5000
    timeout server 5000

frontend apps
    bind 0.0.0.0:80
    option tcplog
    mode tcp
    default_backend apps

frontend apps_ssl
    bind 0.0.0.0:443
    option tcplog
    mode tcp
    default_backend apps_ssl

backend apps
    mode tcp
    balance roundrobin
    server webserver1 ${CRC_IP}:80 check

backend apps_ssl
    mode tcp
    balance roundrobin
    option ssl-hello-chk
    server webserver1 ${CRC_IP}:443 check

frontend api
    bind 0.0.0.0:6443
    option tcplog
    mode tcp
    default_backend api

backend api
    mode tcp
    balance roundrobin
    option ssl-hello-chk
    server webserver1 ${CRC_IP}:6443 check
EOF

sudo systemctl start haproxy
