#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

PLUGIN_HOME="/svc/lib/weblogic-plugin"

strings ${PLUGIN_HOME}/lib/mod_wl.so | grep WLSPLUGINS
