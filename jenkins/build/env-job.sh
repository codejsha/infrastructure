#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

JENKINS_JOB_NAME="app-example-cicd"

# for delete build records (delete-builds)
JENKINS_JOB_RANGE=""
