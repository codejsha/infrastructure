#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

MW_HOME="/usr/local/weblogic"

######################################################################

function bsu_view_applied {
    echo "[INFO] View applied patches..."
    # ${MW_HOME}/utils/bsu/bsu.sh -view -status=applied -prod_dir=${MW_HOME}/wlserver_10.3
    ${MW_HOME}/utils/bsu/bsu.sh -view -status=applied -prod_dir=${MW_HOME}/wlserver_10.3 -verbose
    # ${MW_HOME}/utils/bsu/bsu.sh \
    #     -view \
    #     -status=applied \
    #     -prod_dir=${MW_HOME}/wlserver_10.3 \
    #     -verbose \
    #     -log_priority=debug \
    #     -log=${MW_HOME}/utils/bsu/bsu-install-${PATCH_LIST}.log
    # ${MW_HOME}/utils/bsu/bsu.sh \
    #     -view \
    #     -status=applied \
    #     -prod_dir=${MW_HOME}/wlserver_10.3 \
    #     -patch_download_dir=${MW_HOME}/utils/bsu/cache_dir \
    #     -verbose \
    #     -log_priority=debug \
    #     -log=${MW_HOME}/utils/bsu/bsu-install-${PATCH_LIST}.log
}

######################################################################

bsu_view_applied
