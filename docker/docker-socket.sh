#!/usr/bin/bash

cat <<EOF | sudo tee /etc/systemd/system/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd --host tcp://0.0.0.0:2375 --host unix:///var/run/docker.sock
EOF

systemctl daemon-reload
systemctl restart docker.service
