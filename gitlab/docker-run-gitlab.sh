#!/usr/bin/bash
# https://hub.docker.com/r/gitlab/gitlab-ce

GITLAB_HOME="/mnt/volume/gitlab"
sudo rm -rf ${GITLAB_HOME}
sudo mkdir -p ${GITLAB_HOME}/config
sudo mkdir -p ${GITLAB_HOME}/logs
sudo mkdir -p ${GITLAB_HOME}/data

docker run \
    --detach \
    --name my-gitlab \
    --restart unless-stopped \
    --hostname gitlab.example.com \
    --publish 9443:443 \
    --publish 9480:9480 \
    --publish 9422:22 \
    --env GITLAB_OMNIBUS_CONFIG="external_url 'http://gitlab.example.com:9480'; gitlab_rails['lfs_enabled'] = true; gitlab_rails['gitlab_shell_ssh_port'] = 9422;" \
    --mount type=bind,source=${GITLAB_HOME}/config,target=/etc/gitlab \
    --mount type=bind,source=${GITLAB_HOME}/logs,target=/var/log/gitlab \
    --mount type=bind,source=${GITLAB_HOME}/data,target=/var/opt/gitlab \
    gitlab/gitlab-ce:latest
