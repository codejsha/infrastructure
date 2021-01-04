#!/bin/bash

JAVA_HOME="\/usr\/java\/current"
ORACLE_HOME="\/usr\/local\/weblogic"
ADMIN_SERVER_LISTEN_ADDRESS="test.example.com"
ADMIN_SERVER_LISTEN_PORT="7001"
INSTALL_SCRIPT_DIR="\/svc\/infrastructure\/weblogic"

find . -type f -name "env-base.sh" | xargs perl -pi -e "s/JAVA_HOME=.*/JAVA_HOME=\"${JAVA_HOME}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/ORACLE_HOME=.*/ORACLE_HOME=\"${ORACLE_HOME}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/ADMIN_SERVER_LISTEN_ADDRESS=.*/ADMIN_SERVER_LISTEN_ADDRESS=\"${ADMIN_SERVER_LISTEN_ADDRESS}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/ADMIN_SERVER_LISTEN_PORT=.*/ADMIN_SERVER_LISTEN_PORT=\"${ADMIN_SERVER_LISTEN_PORT}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/INSTALL_SCRIPT_DIR=.*/INSTALL_SCRIPT_DIR=\"${INSTALL_SCRIPT_DIR}\"/"
