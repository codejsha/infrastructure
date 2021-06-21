#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

USERNAME="admin"
PASSWORD="${PASSWORD}"

REGISTRY_VOLUME_DIR="/mnt/volume/registry"
sudo mkdir -p ${REGISTRY_VOLUME_DIR}

sudo yum install -y httpd-tools
sudo htpasswd -cB -b ${REGISTRY_VOLUME_DIR}/htpasswd ${USERNAME} ${PASSWORD}

docker container run \
    --detach \
    --restart unless-stopped \
    --name docker-registry \
    --publish 5000:5000 \
    --mount type="bind",src="${REGISTRY_VOLUME_DIR}",dst="/var/lib/registry" \
    --mount type="bind",src="${REGISTRY_VOLUME_DIR}/htpasswd",dst="/auth/htpasswd" \
    --env REGISTRY_AUTH="htpasswd" \
    --env REGISTRY_AUTH_HTPASSWD_REALM="localhost" \
    --env REGISTRY_AUTH_HTPASSWD_PATH="/auth/htpasswd" \
    registry:2
