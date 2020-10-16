#!/usr/bin/bash

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

######################################################################

function set_module_way_variable{
    DRIVER_NAME="oracle"
    MODULE_NAME="oracle.jdbc"
}

function set_deployment_way_variable{
    DRIVER_NAME="${DRIVER_FILE}"
    DRIVER_RUNTIME_NAME="${DRIVER_FILE}"
}

######################################################################

set_module_way_variable
# set_deployment_way_variable
