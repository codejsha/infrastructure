#!/bin/bash

MW_HOME="/usr/local/ohs"
ORACLE_HOME="${MW_HOME}/oracle_wt1"
INSTANCE_NAME="instance1"
INSTALL_SCRIPT_DIR="/svc/infrastructure/ohs"

MW_HOME="${MW_HOME//\//\/}"
ORACLE_HOME="${ORACLE_HOME//\//\/}"
INSTANCE_NAME="${INSTANCE_NAME//\//\/}"
INSTALL_SCRIPT_DIR="${INSTALL_SCRIPT_DIR//\//\/}"

find . -type f -name "env-base.sh" | xargs perl -pi -e "s/MW_HOME=.*/MW_HOME=\"${MW_HOME}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/ORACLE_HOME=.*/ORACLE_HOME=\"${ORACLE_HOME}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/INSTANCE_NAME=.*/INSTANCE_NAME=\"${INSTANCE_NAME}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/INSTALL_SCRIPT_DIR=.*/INSTALL_SCRIPT_DIR=\"${INSTALL_SCRIPT_DIR}\"/"
perl -pi -e "s/ORACLE_HOME=.*/ORACLE_HOME=\"${ORACLE_HOME}\"/" response-sw-only-11g.rsp
