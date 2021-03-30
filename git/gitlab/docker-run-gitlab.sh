#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

GITLAB_VOLUME_DIR="/mnt/volume/gitlab"
sudo mkdir -p ${GITLAB_VOLUME_DIR}/{config,logs,data}

######################################################################

function docker_run_gitlab {
    docker container run \
        --detach \
        --name gitlab \
        --restart unless-stopped \
        --hostname gitlab \
        --publish 9443:443 \
        --publish 9480:9480 \
        --publish 9422:22 \
        --env GITLAB_OMNIBUS_CONFIG="external_url 'http://gitlab.example.com:9480'; gitlab_rails['lfs_enabled'] = true; gitlab_rails['gitlab_shell_ssh_port'] = 9422;" \
        --mount type="bind",src="${GITLAB_VOLUME_DIR}/config",dst="/etc/gitlab" \
        --mount type="bind",src="${GITLAB_VOLUME_DIR}/data",dst="/var/opt/gitlab" \
        --mount type="bind",src="${GITLAB_VOLUME_DIR}/logs",dst="/var/log/gitlab" \
        gitlab/gitlab-ce:latest
}

######################################################################

docker_run_gitlab
