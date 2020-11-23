#!/bin/bash

source ./env-base.sh

JBOSS_HOME="${JBOSS_HOME}"

${JBOSS_HOME}/bin/standalone.sh -v
