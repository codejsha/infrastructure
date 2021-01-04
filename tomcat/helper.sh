#!/bin/bash

JAVA_HOME="\/usr\/lib\/jvm\/java-11"
# JAVA_HOME="\/usr\/java\/current"
CATALINA_HOME="\/usr\/local\/tomcat"

find . -type f -name "env-base.sh" | xargs perl -pi -e "s/JAVA_HOME=.*/JAVA_HOME=\"${JAVA_HOME}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/CATALINA_HOME=.*/CATALINA_HOME=\"${CATALINA_HOME}\"/"
