#!/bin/bash

source ./env-base.sh

JAVA_HOME="${JAVA_HOME}"
ORACLE_HOME="${ORACLE_HOME}"

######################################################################

function opatch_lsinventory {
    # ${ORACLE_HOME}/OPatch/opatch lsinventory

    ${ORACLE_HOME}/OPatch/opatch lsinventory \
        -all \
        -oh ${ORACLE_HOME} \
        -invPtrLoc ${ORACLE_HOME}/oraInst.loc \
        -jre ${JAVA_HOME}/jre
}

######################################################################

opatch_lsinventory
