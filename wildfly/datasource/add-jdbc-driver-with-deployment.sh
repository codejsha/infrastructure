#!/bin/bash

source ../env-base.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

# DRIVER_FILE_DIR="/mnt/share/oracle-database/11gr2/OJDBC-Full"
# DRIVER_FILE_DIR="/mnt/share/oracle-database/12cr1/OJDBC-Full"
# DRIVER_FILE_DIR="/mnt/share/oracle-database/12cr2/OJDBC-Full"
# DRIVER_FILE_DIR="/mnt/share/oracle-database/18c/ojdbc8-full"
# DRIVER_FILE_DIR="/mnt/share/oracle-database/19c/ojdbc8-full"
DRIVER_FILE_DIR="/mnt/share/oracle-database/19c/ojdbc10-full"

# DRIVER_FILE="ojdbc6.jar"
# DRIVER_FILE="ojdbc7.jar"
# DRIVER_FILE="ojdbc8.jar"
DRIVER_FILE="ojdbc10.jar"

DRIVER_NAME="${DRIVER_FILE}"
DRIVER_RUNTIME_NAME="${DRIVER_FILE}"

######################################################################

function add_jdbc_driver_with_deployment {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
deploy ${DRIVER_FILE_DIR}/${DRIVER_FILE}\
    --name=${DRIVER_NAME}\
    --runtime-name=${DRIVER_RUNTIME_NAME}\
    --unmanaged
run-batch
quit
EOF
}

function check_deployment_status {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
deployment-info --name=${DRIVER_NAME}
run-batch
quit
EOF
}

function check_deployment_status_all {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
deploy -l
run-batch
quit
EOF
}

function get_installed_driver {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=datasources:get-installed-driver(driver-name=${DRIVER_NAME})
run-batch
quit
EOF
}

function get_installed_driver_list {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=datasources:installed-drivers-list
run-batch
quit
EOF
}

######################################################################

add_jdbc_driver_with_deployment
check_deployment_status
# check_deployment_status_all
get_installed_driver
# get_installed_driver_list
