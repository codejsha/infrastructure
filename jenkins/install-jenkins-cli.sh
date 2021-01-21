#!/bin/bash

source ./env-base.sh

if [ ! -f "${JENKINS_FILE_DIR}/jenkins-cli.jar" ]; then
    mkdir -p ${JENKINS_FILE_DIR}
    curl -o ${JENKINS_FILE_DIR}/jenkins-cli.jar -LJO ${JENKINS_URL}/jnlpJars/jenkins-cli.jar
fi
