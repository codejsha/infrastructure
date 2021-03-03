#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -o xtrace

INSTANCE_HOME="/usr/local/ohs/oracle_wt1/instances/instance1"

${INSTANCE_HOME}/bin/opmnctl stopall
