#!/bin/bash

PACKAGE_REPO_VOLUME_DIR="/mnt/volume/example-repo"
cd ${PACKAGE_REPO_VOLUME_DIR}/package

# sudo repotrack ${PACKAGE}

sudo repotrack gcc
sudo repotrack make
sudo repotrack unzip

sudo createrepo --update ${PACKAGE_REPO_VOLUME_DIR}
