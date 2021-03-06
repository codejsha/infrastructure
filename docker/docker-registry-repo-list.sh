#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

USERNAME="admin"
PASSWORD="${PASSWORD}"

curl --insecure --request GET --user ${USERNAME}:${PASSWORD} "https://registry.example.com/v2/_catalog"
