#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "insecure-registries": ["registry.example.com", "core.harbor.example.com", "kraken.example.com", "nexus.example.com"],
  "registry-mirrors": ["https://nexus.example.com", "http://nexus.example.com"]
}
EOF

systemctl daemon-reload
systemctl restart docker.service
