#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

IPLANET_HOME="/usr/local/iplanet"
PLUGIN_HOME="${IPLANET_HOME}/plugins/weblogic-plugin"

# PLUGIN_FILE_DIR="/mnt/share/oracle-http-server/ohs11.1.1.9/ofm_wlsplugins_generic_11.1.1.9.0_disk1_1of1"
PLUGIN_FILE_DIR="/mnt/share/oracle-http-server/ohs12.2.1.3/fmw_12.2.1.3.0_wlsplugins_Disk1_1of1"

# PLUGIN_FILE="WLSPlugin11g-64bit-iPlanet7.0-linux64-x86_64.zip"
PLUGIN_FILE="WLSPlugin12.2.1.3.0-iPlanet7.0-Linux_x86_64-12.2.1.3.0.zip"

######################################################################

unzip -d ${PLUGIN_HOME} ${PLUGIN_FILE_DIR}/${PLUGIN_FILE}
