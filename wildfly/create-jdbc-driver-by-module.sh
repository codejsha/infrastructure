#!/usr/bin/bash

source ./env-base.sh
source ./env-jdbc-driver.sh

######################################################################

function add_jdbc_module {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="module add --name=${MODULE_NAME} \
            --resources=${DRIVER_FILE_DIR}/${DRIVER_FILE} \
            --dependencies=javax.api,javax.transaction.api"
}

function add_jdbc_driver_by_module {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="/subsystem=datasources/jdbc-driver=${DRIVER_NAME}\
            :add(\
            driver-name=${DRIVER_NAME},\
            driver-module-name=${MODULE_NAME})"
}

function get_installed_driver {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="/subsystem=datasources:get-installed-driver(driver-name=${DRIVER_NAME})"
}

function get_installed_driver_list {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="/subsystem=datasources:installed-drivers-list"
}

######################################################################

add_jdbc_module
add_jdbc_driver_by_module
get_installed_driver
# get_installed_driver_list
