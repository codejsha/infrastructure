#!/usr/bin/bash

ORACLE_HOME="/usr/local/ohs"
MAJOR_VERSION="12c"    # (available: 11g, 12c)

function check_version_with_directory {
    if [ "${MAJOR_VERSION}" == "11g" ]; then
        ls ${ORACLE_HOME}/inventory/Components21/oracle.ohs2
    elif [ "${MAJOR_VERSION}" == "12c" ]; then
        ls ${ORACLE_HOME}/inventory/Components/oracle.ohs2
    fi
}

function check_version_with_httpd {
    if [ "${MAJOR_VERSION}" == "11g" ]; then
        export ORACLE_HOME=${ORACLE_HOME}
        export LD_LIBRARY_PATH=${ORACLE_HOME}/lib:${ORACLE_HOME}/ohs/lib
        ${ORACLE_HOME}/ohs/bin/httpd -version
    elif [ "${MAJOR_VERSION}" == "12c" ]; then
        export ORACLE_HOME=${ORACLE_HOME}
        export LD_LIBRARY_PATH=${ORACLE_HOME}/lib:${ORACLE_HOME}/ohs/lib:${ORACLE_HOME}/oracle_common/lib
        ${ORACLE_HOME}/ohs/bin/httpd -version
    fi
}

# check_version_with_directory
### 11g Result:
### 06/26/2019  11:23 AM    <DIR>          11.1.1.9.0
###
### 12c Result:
### 06/26/2019  01:42 PM    <DIR>          12.1.3.0.0
### 06/26/2019  01:13 PM    <DIR>          12.2.1.3.0

check_version_with_httpd
### 11g Result:
### Server version: Oracle-HTTP-Server/2.2.22 (Unix)
### Server built:   Mar 20 2015 20:48:14
### Server label:   APACHE_11.1.1.9.0_LINUX.X64_150320.1901
###
### 12c Result:
### Server version: Oracle-HTTP-Server-12.2.1.3.0/2.4.25 (Unix)
### Server built:   Aug 17 2017 18:56:05"
