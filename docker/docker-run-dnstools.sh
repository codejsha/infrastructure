#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

docker container run \
    --rm \
    --interactive \
    --tty \
    --name dnstools \
    infoblox/dnstools:latest
