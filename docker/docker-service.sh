#!/bin/bash

sudo mkdir -p /etc/systemd/system/docker.service.d

cat <<EOF | sudo tee /etc/systemd/system/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock --host tcp://0.0.0.0:2375
EOF

systemctl daemon-reload
systemctl restart docker.service
