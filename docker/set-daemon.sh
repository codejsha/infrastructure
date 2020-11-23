#!/bin/bash

cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "insecure-registries": ["registry.example.com", "core.harbor.example.com", "kraken.example.com", "nexus.example.com"],
  "registry-mirrors": ["https://nexus.example.com", "http://nexus.example.com"]
}
EOF

systemctl daemon-reload
systemctl restart docker.service
