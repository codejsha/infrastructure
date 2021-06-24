#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

# docker image build --tag tomcat-starter:9 .
# docker image tag tomcat-starter:9 registry.example.com/tomcat-starter:9
# docker image tag tomcat-starter:9 core.harbor.example.com/library/tomcat-starter:9
# docker image push registry.example.com/tomcat-starter:9
# docker image push core.harbor.example.com/library/tomcat-starter:9

# docker image build --file Dockerfile.dev --tag tomcat-starter:9-dev .
# docker image tag tomcat-starter:9-dev registry.example.com/tomcat-starter:9-dev
# docker image tag tomcat-starter:9-dev core.harbor.example.com/library/tomcat-starter:9-dev
# docker image push core.harbor.example.com/library/tomcat-starter:9-dev

docker image build --file Dockerfile.dev --tag tomcat-starter:latest .
# docker image tag tomcat-starter:latest registry.example.com/tomcat-starter:latest
docker image tag tomcat-starter:latest core.harbor.example.com/library/tomcat-starter:latest
# docker image push registry.example.com/tomcat-starter:latest
docker image push core.harbor.example.com/library/tomcat-starter:latest
