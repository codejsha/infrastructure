#!/bin/bash

cat <<EOF | sudo tee /etc/yum.repos.d/example-repo.repo
[example-repo]
name=Example Package Repository
baseurl=http://test.example.com:8888/example-repo
enabled=1
gpgcheck=0
priority=1
EOF

# sudo /usr/bin/cp -f client/example-repo.repo /etc/yum.repos.d/example-repo.repo
