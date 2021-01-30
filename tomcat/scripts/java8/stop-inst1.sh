#!/bin/bash

INSTANCE_NAME="inst1"
export JAVA_HOME="/usr/lib/jvm/java-1.8.0"
export JRE_HOME="/usr/lib/jvm/jre-1.8.0"
export CATALINA_HOME="/usr/local/tomcat"
export CATALINA_BASE="${CATALINA_HOME}/instances/${INSTANCE_NAME}"

${CATALINA_HOME}/bin/shutdown.sh
