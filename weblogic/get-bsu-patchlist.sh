#!/usr/bin/bash

MW_HOME="/usr/local/weblogic"

function bsu_view_applied {
    echo "[INFO] View applied patches..."
    ${MW_HOME}/utils/bsu/bsu.sh -view -status=applied -prod_dir=${MW_HOME}/wlserver_10.3
}

bsu_view_applied
