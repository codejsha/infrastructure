#!/usr/bin/bash

source ../env-base.sh

PASSWORD="${1}"

${JAVA_HOME}/bin/java \
    -classpath ${JBOSS_HOME}/modules/system/layers/base/org/picketbox/main/picketbox-5.0.3.Final-redhat-00005.jar \
    org.picketbox.datasource.security.SecureIdentityLoginModule ${PASSWORD}
