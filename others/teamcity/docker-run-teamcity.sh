#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

docker container run \
    --interactive \
    --tty \
    --name teamcity-server-instance \
    --publish 8111:8111 \
    --mount type=bind,src=/mnt/volume/teamcity/datadir,dst=/data/teamcity_server/datadir \
    --mount type=bind,src=/mnt/volume/teamcity/logs,dst=/opt/teamcity/logs \
    jetbrains/teamcity-server
