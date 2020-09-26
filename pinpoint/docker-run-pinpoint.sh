#!/usr/bin/bash
# https://github.com/naver/pinpoint-docker

VERSION="2.0.4"

git clone https://github.com/naver/pinpoint-docker.git
cd pinpoint-docker
git checkout ${VERSION}
docker-compose pull && docker-compose up -d
