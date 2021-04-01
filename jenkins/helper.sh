#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

JENKINS_USER="admin"
JENKINS_API_TOKEN="JENKINS_API_TOKEN"
JENKINS_URL="http://jenkins.example.com"
# JENKINS_FILE_DIR="${HOME}/.jenkins"
JAVA_HOME="/usr/lib/jvm/java-11"

######################################################################

### escape forward slash
JENKINS_URL="${JENKINS_URL//\//\\/}"
# JENKINS_FILE_DIR="${JENKINS_FILE_DIR//\//\\/}"
JAVA_HOME="${JAVA_HOME//\//\\/}"

######################################################################

find . -type f -name "env-base.sh" | xargs perl -pi -e "s/JENKINS_USER=.*/JENKINS_USER=\"${JENKINS_USER}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/JENKINS_API_TOKEN=.*/JENKINS_API_TOKEN=\"${JENKINS_API_TOKEN}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/JENKINS_URL=.*/JENKINS_URL=\"${JENKINS_URL}\"/"
# find . -type f -name "env-base.sh" | xargs perl -pi -e "s/JENKINS_FILE_DIR=.*/JENKINS_FILE_DIR=\"${JENKINS_FILE_DIR}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/JAVA_HOME=.*/JAVA_HOME=\"${JAVA_HOME}\"/"
