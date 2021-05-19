#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

sudo mkdir -p /etc/systemd/system/docker.service.d

cat <<EOF | sudo tee /etc/systemd/system/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock --host tcp://0.0.0.0:2375
EOF

# cat <<EOF | sudo tee /etc/systemd/system/docker.service.d/override.conf
# [Service]
# ExecStart=
# ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock --host tcp://0.0.0.0:2375 --dns 8.8.8.8 --dns 168.126.63.1
# EOF

# cat <<EOF | sudo tee /etc/systemd/system/docker.service.d/override.conf
# [Service]
# ExecStart=
# ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock --host tcp://0.0.0.0:2375 --dns 192.168.137.1 --dns 8.8.8.8 --dns 168.126.63.1
# EOF

# cat <<EOF | sudo tee /etc/systemd/system/docker.service.d/override.conf
# [Service]
# ExecStart=
# ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock --host tcp://0.0.0.0:2375 --dns 192.168.138.1 --dns 8.8.8.8 --dns 168.126.63.1
# EOF

sudo systemctl daemon-reload
sudo systemctl restart docker.service
