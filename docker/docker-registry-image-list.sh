#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

USERNAME="admin"
PASSWORD="${PASSWORD}"
IMAGE_NAME="${1}"

if [ -n "${IMAGE_NAME}" ]; then
    curl --request GET --user ${USERNAME}:${PASSWORD} "http://registry.example.com/v2/${IMAGE_NAME}/tags/list"
else
    printf "\x1b[38;2;216;80;80mUsage: docker-registry-image-list IMAGE_NAME\x1b[0m\n"
fi
