#!/bin/bash

JAVA_HOME="/usr/lib/jvm/java-11"
JRE_HOME="/usr/lib/jvm/jre-11"
# JAVA_HOME="/usr/lib/jvm/java-1.8.0"
# JRE_HOME="/usr/lib/jvm/jre-1.8.0"
CATALINA_HOME="/usr/local/tomcat"

JAVA_HOME="${JAVA_HOME//\//\/}"
JRE_HOME="${JRE_HOME//\//\/}"
CATALINA_HOME="${CATALINA_HOME//\//\/}"

find . -type f -name "env-base.sh" | xargs perl -pi -e "s/JAVA_HOME=.*/JAVA_HOME=\"${JAVA_HOME}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/JRE_HOME=.*/JRE_HOME=\"${JRE_HOME}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/CATALINA_HOME=.*/CATALINA_HOME=\"${CATALINA_HOME}\"/"
