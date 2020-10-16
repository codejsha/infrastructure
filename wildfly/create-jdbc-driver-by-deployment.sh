#!/usr/bin/bash

source ./env-base.sh
source ./env-jdbc-driver.sh

######################################################################

function add_jdbc_driver_by_deployment {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="deploy ${DRIVER_FILE_DIR}/${DRIVER_FILE} \
            --name=${DRIVER_NAME} \
            --runtime-name=${DRIVER_RUNTIME_NAME} \
            --unmanaged"
}

function check_deployment_status {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="deployment-info --name=${DRIVER_NAME}"
}

function check_deployment_status_all {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="deploy -l"
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

add_jdbc_driver_by_deployment
check_deployment_status
# check_deployment_status_all
get_installed_driver
# get_installed_driver_list
