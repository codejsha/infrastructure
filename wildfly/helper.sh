#!/bin/bash

JAVA_HOME="\/usr\/lib\/jvm\/java-11"
JBOSS_HOME="\/usr\/local\/wildfly"
BIND_ADDRESS="0.0.0.0"
BIND_ADDRESS_MGMT="127.0.0.1"

find . -type f -name "env-base.sh" | xargs perl -pi -e "s/^JAVA_HOME=.*/JAVA_HOME=\"${JAVA_HOME}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/^JBOSS_HOME=.*/JBOSS_HOME=\"${JBOSS_HOME}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/^BIND_ADDRESS=.*/BIND_ADDRESS=\"${BIND_ADDRESS}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/^BIND_ADDRESS_MGMT=.*/BIND_ADDRESS_MGMT=\"${BIND_ADDRESS_MGMT}\"/"
