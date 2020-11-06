#!/usr/bin/bash

JAVA_HOME="/usr/java/java-1.8.0"
# JAVA_HOME="/usr/java/java-11"

ORACLE_HOME="/usr/local/weblogic"

function opatch_lsinventory {
    ${ORACLE_HOME}/OPatch/opatch lsinventory

    # ${ORACLE_HOME}/OPatch/opatch lsinventory \
    #     -all \
    #     -oh ${ORACLE_HOME} \
    #     -invPtrLoc ${ORACLE_HOME}/oraInst.loc \
    #     -jre ${JAVA_HOME}/jre
}

opatch_lsinventory
