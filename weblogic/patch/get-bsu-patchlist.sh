#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

MW_HOME="/usr/local/weblogic"

######################################################################

function bsu_view_applied {
    echo "[INFO] View applied patches..."
    ${MW_HOME}/utils/bsu/bsu.sh -view -status=applied -prod_dir=${MW_HOME}/wlserver_10.3 -verbose
}

######################################################################

bsu_view_applied
