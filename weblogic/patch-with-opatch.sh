#!/usr/bin/bash

JAVA_HOME="/usr/java/java-1.8.0"
# JAVA_HOME="/usr/java/java-11"

ORACLE_HOME="/usr/local/weblogic"
INVENTORY_FILE="${ORACLE_HOME}/oraInst.loc"

# PATCH_FILE_DIR="/mnt/share/oracle-weblogic-server/wls12.1.3"
PATCH_FILE_DIR="/mnt/share/oracle-weblogic-server/wls12.2.1.3"
# PATCH_FILE_DIR="/mnt/share/oracle-weblogic-server/wls12.2.1.4"
# PATCH_FILE_DIR="/mnt/share/oracle-weblogic-server/wls14.1.1"

######################################################################

function check_java_home {
    if [ ! -d "${JAVA_HOME}" ]; then
        echo "[ERROR] The JAVA_HOME (${JAVA_HOME}) does not exists!"
        exit
    fi
}

function check_oracle_home {
    if [ ! -d "${ORACLE_HOME}" ]; then
        echo "[ERROR] The ORACLE_HOME (${ORACLE_HOME}) does not exists!"
        exit
    fi

    mkdir -p ${ORACLE_HOME}/OPatch/patch_files
}

function check_inventory_group {
    ORACLE_HOME_GROUP="$(stat -c '%G' ${ORACLE_HOME})"
    INST_GROUP="$(grep inst_group ${INVENTORY_FILE} | cut -d'=' -f 2)"

    if [[ "${ORACLE_HOME_GROUP}" != "${INST_GROUP}" ]]; then
        echo "[ERROR] The group of ORACLE_HOME directory (${ORACLE_HOME_GROUP}) and the inst_group value (${INST_GROUP}) are not the same!"
        exit
    fi
}

function check_inventory_location {
    INVENTORY_LOC="$(grep inventory_loc ${INVENTORY_FILE} | cut -d'=' -f 2)"

    if [ ! -d "${INVENTORY_LOC}" ]; then
        echo "[ERROR] The Oracle Inventory directory (${INVENTORY_LOC}) does not exists!"
        exit
    fi
}

function check_patch_file {
    PATCH_FILE_PATH="${1}"

    if [ ! -f "${PATCH_FILE_PATH}" ]; then
        echo "[ERROR] The PATCH_FILE (${PATCH_FILE_PATH}) does not exists!"
        exit
    fi
}

function opatch_update {
    PATCH_FILE="${1}"
    PATCH_ID="${2}"

    check_patch_file ${PATCH_FILE_DIR}/${PATCH_FILE}
    unzip -q -o ${PATCH_FILE_DIR}/${PATCH_FILE} -d ${ORACLE_HOME}/OPatch/patch_files
    ${JAVA_HOME}/bin/java \
        -jar ${ORACLE_HOME}/OPatch/patch_files/${PATCH_ID}/opatch_generic.jar \
        -silent oracle_home=${ORACLE_HOME} \
        -ignoreSysPrereqs

    STATUS="${?}"
    if [ "${STATUS}" -ne "0" ]; then
        echo "[ERROR] The update (${PATCH_ID}) not completed!"
        exit
    fi
}

function opatch_rollback {
    PATCH_ID="${1}"

    ${ORACLE_HOME}/OPatch/opatch rollback -silent -id ${PATCH_ID}

    STATUS="${?}"
    if [ "${STATUS}" -ne "0" ]; then
        echo "[ERROR] The rollback (${PATCH_ID}) not completed!"
        exit
    fi
}

function opatch_apply {
    PATCH_FILE="${1}"
    PATCH_ID="${2}"
    if [ -z "${PATCH_ID}" ]; then
        PATCH_ID_TEMP="${1/_*/}"
        PATCH_ID="${PATCH_ID_TEMP/p/}"
    fi

    check_patch_file ${PATCH_FILE_DIR}/${PATCH_FILE}
    unzip -q -o ${PATCH_FILE_DIR}/${PATCH_FILE} -d ${ORACLE_HOME}/OPatch/patch_files
    ${ORACLE_HOME}/OPatch/opatch apply -silent ${ORACLE_HOME}/OPatch/patch_files/${PATCH_ID}

    STATUS="${?}"
    if [ "${STATUS}" -ne "0" ]; then
        echo "[ERROR] The patch (${PATCH_ID}) not completed!"
        exit
    fi
}

function opatch_lsinventory {
    # ${ORACLE_HOME}/OPatch/opatch lsinventory

    ${ORACLE_HOME}/OPatch/opatch lsinventory \
        -all \
        -oh ${ORACLE_HOME} \
        -invPtrLoc ${INVENTORY_FILE} \
        -jre ${JAVA_HOME}/jre
}

######################################################################

# export ORACLE_HOME="${ORACLE_HOME}"
# export PATH="${ORACLE_HOME}/OPatch:${PATH}"

check_java_home
check_oracle_home
check_inventory_group
check_inventory_location

opatch_update "p28186730_139424_Generic.zip" "6880880"
# opatch_rollback "30675853"
# opatch_apply "p31101362_1394002_Generic.zip"
opatch_apply "p31961038_122130_Generic.zip"

opatch_lsinventory
