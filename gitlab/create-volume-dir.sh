#!/usr/bin/bash

GITLAB_MOUNT_DIR="/mnt/volume/gitlab"
sudo rm -rf ${GITLAB_MOUNT_DIR}
sudo mkdir -p ${GITLAB_MOUNT_DIR}/config
sudo mkdir -p ${GITLAB_MOUNT_DIR}/logs
sudo mkdir -p ${GITLAB_MOUNT_DIR}/data
