#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

JENKINS_JOB_NAME="app-example-cicd"

# for delete build records (delete-builds)
JENKINS_JOB_RANGE=""
