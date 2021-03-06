#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

PLUGIN_HOME="/svc/lib/weblogic-plugin"

strings ${PLUGIN_HOME}/lib/mod_wl.so | grep WLSPLUGINS
