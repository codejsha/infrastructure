#!/bin/bash

cat <<EOF | sudo tee /etc/systemd/system/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd --host unix:///var/run/docker.sock --host tcp://0.0.0.0:2375
EOF

systemctl daemon-reload
systemctl restart docker.service
