#!/bin/bash

INSTANCE_NAME="inst1"
export JAVA_HOME="/usr/lib/jvm/java-11"
export JRE_HOME="/usr/lib/jvm/jre-11"
export CATALINA_HOME="/usr/local/tomcat"
export CATALINA_BASE="${CATALINA_HOME}/instances/${INSTANCE_NAME}"

${CATALINA_HOME}/bin/shutdown.sh
