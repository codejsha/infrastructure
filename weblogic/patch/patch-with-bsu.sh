#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

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
    local PATCH_FILE_PATH="${1}"

    if [ ! -f "${PATCH_FILE_PATH}" ]; then
        echo "[ERROR] The PATCH_FILE (${PATCH_FILE_PATH}) does not exist!"
        exit
    fi
}

function change_bsu_mem_args {
    local MEM_ARGS="${1:-"-Xms4096m -Xmx4096m"}"
    sed -i "s/MEM_ARGS=.*/MEM_ARGS=\"${MEM_ARGS}\"/g" ${MW_HOME}/utils/bsu/bsu.sh
}

function backup_cache_dir {
    local DATETIME="$(date +'%Y%m%d_%H%M%S')"
    mv ${MW_HOME}/utils/bsu/cache_dir ${MW_HOME}/utils/bsu/cache_dir_${DATETIME}
}

function bsu_update {
    local PATCH_FILE="${1}"

    cd ${MW_HOME}/utils/bsu
    check_patch_file ${PATCH_FILE_DIR}/${PATCH_FILE}
    unzip -q -o ${PATCH_FILE_DIR}/${PATCH_FILE} -d ${MW_HOME}/utils/bsu
    chmod 750 ${MW_HOME}/utils/bsu/bsu_update.sh

    ${MW_HOME}/utils/bsu/bsu_update.sh install
}

function bsu_remove {
    local PATCH_FILE="${1}"
    local PATCH_LIST="${2}"

    cd ${MW_HOME}/utils/bsu

    echo "[INFO] The patch (${PATCH_LIST}) is removing..."
    ${MW_HOME}/utils/bsu/bsu.sh -remove -patchlist=${PATCH_LIST} -prod_dir=${MW_HOME}/wlserver_10.3
    # ${MW_HOME}/utils/bsu/bsu.sh -remove -patchlist=${PATCH_LIST} -prod_dir=${MW_HOME}/wlserver_10.3 -verbose
    # ${MW_HOME}/utils/bsu/bsu.sh \
    #     -remove \
    #     -patchlist=${PATCH_LIST} \
    #     -prod_dir=${MW_HOME}/wlserver_10.3 \
    #     -verbose \
    #     -log_priority=debug \
    #     -log=${MW_HOME}/utils/bsu/bsu-remove-${PATCH_LIST}.log
}

function bsu_install {
    local PATCH_FILE="${1}"
    local PATCH_LIST="${2}"

    cd ${MW_HOME}/utils/bsu
    check_patch_file ${PATCH_FILE_DIR}/${PATCH_FILE}
    unzip -q -o ${PATCH_FILE_DIR}/${PATCH_FILE} -d ${MW_HOME}/utils/bsu/cache_dir

    echo "[INFO] The patch (${PATCH_LIST}) is installing..."
    ${MW_HOME}/utils/bsu/bsu.sh -install -patchlist=${PATCH_LIST} -prod_dir=${MW_HOME}/wlserver_10.3
    # ${MW_HOME}/utils/bsu/bsu.sh -install -patchlist=${PATCH_LIST} -prod_dir=${MW_HOME}/wlserver_10.3 -verbose
    # ${MW_HOME}/utils/bsu/bsu.sh \
    #     -install \
    #     -patchlist=${PATCH_LIST} \
    #     -prod_dir=${MW_HOME}/wlserver_10.3 \
    #     -verbose \
    #     -log_priority=debug \
    #     -log=${MW_HOME}/utils/bsu/bsu-install-${PATCH_LIST}.log
}

function bsu_view_applied {
    cd ${MW_HOME}/utils/bsu

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
}

######################################################################

check_middleware_home
change_bsu_mem_args "-Xms4096m -Xmx4096m"

bsu_update "p27238412_1036_Generic.zip"

# bsu_remove "p30463097_1036_Generic.zip" "JWEB"
# backup_cache_dir
bsu_install "p30857748_1036_Generic.zip" "Q3ZB"

bsu_view_applied
