#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

JENKINS_USER="admin"
JENKINS_API_TOKEN="JENKINS_API_TOKEN"
JENKINS_URL="http://jenkins.example.com"
# JENKINS_FILE_DIR="${HOME}/.jenkins"

JAVA_HOME="/usr/lib/jvm/java-11"
# JAVA_HOME="/usr/lib/jvm/java-1.8.0"


######################################################################

### escape forward slash
JENKINS_URL="${JENKINS_URL//\//\\/}"
# JENKINS_FILE_DIR="${JENKINS_FILE_DIR//\//\\/}"
JAVA_HOME="${JAVA_HOME//\//\\/}"

######################################################################

perl -pi -e "s/JENKINS_USER=.*/JENKINS_USER=\"${JENKINS_USER}\"/" env-base.sh
perl -pi -e "s/JENKINS_API_TOKEN=.*/JENKINS_API_TOKEN=\"${JENKINS_API_TOKEN}\"/" env-base.sh
perl -pi -e "s/JENKINS_URL=.*/JENKINS_URL=\"${JENKINS_URL}\"/" env-base.sh
# perl -pi -e "s/JENKINS_FILE_DIR=.*/JENKINS_FILE_DIR=\"${JENKINS_FILE_DIR}\"/" env-base.sh
perl -pi -e "s/JAVA_HOME=.*/JAVA_HOME=\"${JAVA_HOME}\"/" env-base.sh
