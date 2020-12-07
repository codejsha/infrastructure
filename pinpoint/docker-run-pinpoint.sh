#!/bin/bash

PINPOINT_VERSION="2.1.0"

git clone https://github.com/naver/pinpoint-docker.git
# gh repo clone naver/pinpoint-docker

cd pinpoint-docker
git checkout ${PINPOINT_VERSION}
docker-compose pull && docker-compose up -d
