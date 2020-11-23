#!/bin/bash

GITLAB_VOLUME_DIR="/mnt/volume/gitlab"
sudo rm -rf ${GITLAB_VOLUME_DIR}
sudo mkdir -p ${GITLAB_VOLUME_DIR}/config
sudo mkdir -p ${GITLAB_VOLUME_DIR}/logs
sudo mkdir -p ${GITLAB_VOLUME_DIR}/data
