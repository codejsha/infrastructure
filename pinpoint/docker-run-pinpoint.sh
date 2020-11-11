#!/usr/bin/bash
# https://github.com/naver/pinpoint-docker

PINPOINT_VERSION="2.1.0"

git clone https://github.com/naver/pinpoint-docker.git
cd pinpoint-docker
git checkout ${PINPOINT_VERSION}
docker-compose pull && docker-compose up -d
