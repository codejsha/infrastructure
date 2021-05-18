#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "insecure-registries": ["registry.example.com", "core.harbor.example.com", "kraken.example.com", "nexus.example.com"],
  "registry-mirrors": ["https://nexus.example.com", "http://nexus.example.com"]
}
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker.service
