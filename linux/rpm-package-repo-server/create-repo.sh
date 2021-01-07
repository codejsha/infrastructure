#!/bin/bash

sudo yum install -y yum-utils createrepo

PACKAGE_REPO_VOLUME_DIR="/mnt/volume/example-repo"
sudo mkdir -p ${PACKAGE_REPO_VOLUME_DIR}/package

sudo createrepo ${PACKAGE_REPO_VOLUME_DIR}
