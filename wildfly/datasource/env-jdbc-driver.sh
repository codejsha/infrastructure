#!/bin/bash

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

### module
DRIVER_NAME="oracle"
MODULE_NAME="com.oracle"

### deployment
DRIVER_NAME="${DRIVER_FILE}"
DRIVER_RUNTIME_NAME="${DRIVER_FILE}"


######################################################################

function print_help {
    echo "  --driver-name|--driver-name=  : set the name of jdbc driver"
    echo "  --module-name|--module-name=  : set the module name of jdbc driver"
    echo "  --driver-runtime-name|--driver-runtime-name=  : set the driver runtime name of jdbc driver"
}

function set_arguments {
    while [[ $# -gt 0 ]]
    do
        ARGS="${1}"
        shift
        case "${ARGS}" in
            "--help")                   print_help;                         exit;;
            "--driver-name")            DRIVER_NAME="${1}";                 shift;;
            "--driver-name="*)          DRIVER_NAME="${ARGS#*=}";           ;;
            "--module-name")            MODULE_NAME="${1}";                 shift;;
            "--module-name="*)          MODULE_NAME="${ARGS#*=}";           ;;
            "--driver-runtime-name")    DRIVER_RUNTIME_NAME="${1}";         shift;;
            "--driver-runtime-name="*)  DRIVER_RUNTIME_NAME="${ARGS#*=}";   ;;
        esac
    done
}

######################################################################

set_arguments ${@}
