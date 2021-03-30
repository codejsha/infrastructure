#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

cat <<EOF | sudo tee /etc/yum.repos.d/example-repo.repo
[example-repo]
name=Example Package Repository
baseurl=http://test.example.com:8888/example-repo
enabled=1
gpgcheck=0
priority=1
EOF

# sudo /bin/cp -f client/example-repo.repo /etc/yum.repos.d/example-repo.repo
