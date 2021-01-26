#!/bin/bash

MW_HOME="/usr/local/weblogic"
PATCH_FILE_DIR="/mnt/share/oracle-weblogic-server/wls10.3.6"

######################################################################

function check_middleware_home {
    if [ ! -d "${MW_HOME}" ]; then
        echo "[ERROR] The MW_HOME (${MW_HOME}) does not exist!"
        exit
    fi

    mkdir -p ${MW_HOME}/utils/bsu/cache_dir
}

function check_patch_file {
    PATCH_FILE_PATH="${1}"

    if [ ! -f "${PATCH_FILE_PATH}" ]; then
        echo "[ERROR] The PATCH_FILE (${PATCH_FILE_PATH}) does not exist!"
        exit
    fi
}

function change_bsu_mem_args {
    MEM_ARGS="${1:-"-Xms4096m -Xmx4096m"}"
    sed -i "s/MEM_ARGS=.*/MEM_ARGS=\"${MEM_ARGS}\"/g" ${MW_HOME}/utils/bsu/bsu.sh
}

function backup_cache_dir {
    GET_DATE="$(date +'%Y%m%d_%H%M%S')"
    mv ${MW_HOME}/utils/bsu/cache_dir ${MW_HOME}/utils/bsu/cache_dir_${GET_DATE}
}

function bsu_update {
    PATCH_FILE="${1}"

    cd ${MW_HOME}/utils/bsu
    check_patch_file ${PATCH_FILE_DIR}/${PATCH_FILE}
    unzip -q -o ${PATCH_FILE_DIR}/${PATCH_FILE} -d ${MW_HOME}/utils/bsu
    chmod 750 ${MW_HOME}/utils/bsu/bsu_update.sh
    ${MW_HOME}/utils/bsu/bsu_update.sh install

    STATUS="${?}"
    if [ "${STATUS}" -ne "0" ]; then
        echo "[ERROR] The update (${PATCH_ID}) is not completed!"
        exit
    fi
}

function bsu_remove {
    PATCH_FILE="${1}"
    PATCH_LIST="${2}"

    cd ${MW_HOME}/utils/bsu
    echo "[INFO] The patch (${PATCH_LIST}) is removing..."
    ${MW_HOME}/utils/bsu/bsu.sh -remove -patchlist=${PATCH_LIST} -prod_dir=${MW_HOME}/wlserver_10.3

    STATUS="${?}"
    if [ "${STATUS}" -ne "0" ]; then
        echo "[ERROR] The rollback (${PATCH_LIST}) is not completed!"
        exit
    fi
}

function bsu_install {
    PATCH_FILE="${1}"
    PATCH_LIST="${2}"

    cd ${MW_HOME}/utils/bsu
    check_patch_file ${PATCH_FILE_DIR}/${PATCH_FILE}
    unzip -q -o ${PATCH_FILE_DIR}/${PATCH_FILE} -d ${MW_HOME}/utils/bsu/cache_dir
    echo "[INFO] The patch (${PATCH_LIST}) is installing..."
    ${MW_HOME}/utils/bsu/bsu.sh -install -patchlist=${PATCH_LIST} -prod_dir=${MW_HOME}/wlserver_10.3

    STATUS="${?}"
    if [ "${STATUS}" -ne "0" ]; then
        echo "[ERROR] The patch (${PATCH_LIST}) is not completed!"
        exit
    fi
}

function bsu_view_applied {
    cd ${MW_HOME}/utils/bsu
    echo "[INFO] View applied patches..."
    ${MW_HOME}/utils/bsu/bsu.sh -view -status=applied -prod_dir=${MW_HOME}/wlserver_10.3 -verbose
}

######################################################################

check_middleware_home
change_bsu_mem_args "-Xms4096m -Xmx4096m"

bsu_update "p27238412_1036_Generic.zip"
# bsu_remove "p30463097_1036_Generic.zip" "JWEB"
# backup_cache_dir
bsu_install "p30857748_1036_Generic.zip" "Q3ZB"

bsu_view_applied
