#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

kubectl run --rm -it --restart=Never --image=docker.pkg.github.com/linkedin/burrow/burrow:latest burrow