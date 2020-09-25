#!/usr/bin/bash

GITLAB_HOME="/mnt/volume/gitlab"
sudo rm -rf ${GITLAB_HOME}
sudo mkdir -p ${GITLAB_HOME}/config
sudo mkdir -p ${GITLAB_HOME}/logs
sudo mkdir -p ${GITLAB_HOME}/data
