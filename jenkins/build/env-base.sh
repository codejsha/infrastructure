#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

JENKINS_USER="admin"
JENKINS_API_TOKEN="JENKINS_API_TOKEN"
JENKINS_URL="http://jenkins.example.com"
JENKINS_FILE_DIR="${HOME}/.jenkins"
JAVA_HOME="/usr/lib/jvm/java-11"
