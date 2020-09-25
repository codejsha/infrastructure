#!/usr/bin/bash

JAVA_HOME="/usr/java/java-1.8.0"
# JAVA_HOME="/usr/java/java-11"
ORACLE_HOME="/usr/local/weblogic"
PATCH_FILE_DIR="/mnt/share/oracle-weblogic-server/wls12.2.1.3"

######################################################################

function check_requirement {
    if [ ! -d "${JAVA_HOME}" ]; then
        echo "ERROR: The JAVA_HOME (${JAVA_HOME}) does not exists!"
        exit
    fi
    if [ ! -d "${ORACLE_HOME}" ]; then
        echo "ERROR: The ORACLE_HOME (${ORACLE_HOME}) does not exists!"
        exit
    fi

    mkdir -p ${ORACLE_HOME}/OPatch/patch_files
}

function check_patch_file {
    PATCH_FILE_PATH="${1}"

    if [ ! -f "${PATCH_FILE_PATH}" ]; then
        echo "ERROR: The PATCH_FILE (${PATCH_FILE_PATH}) does not exists!"
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
}

function opatch_rollback {
    PATCH_ID="${1}"

    ${ORACLE_HOME}/OPatch/opatch rollback -silent -id ${PATCH_ID}
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
}

function opatch_lsinventory {
    ${ORACLE_HOME}/OPatch/opatch lsinventory
    # ${ORACLE_HOME}/OPatch/opatch lsinventory -invPtrLoc ${ORACLE_HOME}/oraInst.loc
}

######################################################################

check_requirement
opatch_update "p28186730_139422_Generic.zip" "6880880"
# opatch_rollback 30675853
opatch_apply "p31101362_1394002_Generic.zip"
opatch_apply "p30965714_122130_Generic.zip"
opatch_lsinventory
