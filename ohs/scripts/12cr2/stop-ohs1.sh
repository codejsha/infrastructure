#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

DOMAIN_HOME="/usr/local/ohs/user_projects/domains/base_domain"
COMPONENT_NAME="ohs1"

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
${DOMAIN_HOME}/bin/stopComponent.sh ${COMPONENT_NAME}