#!/bin/bash

DOMAIN_HOME="/usr/local/ohs/user_projects/domains/base_domain"

PID="$(pgrep -xa java | grep ${DOMAIN_HOME} | grep NodeManager | awk '{print $1}')"
kill -9 ${PID}
