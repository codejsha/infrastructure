#!/usr/bin/bash

source ../env-base.sh

######################################################################

function print_help {
    echo "  --path|--path=                : set a application path."
    echo "  --name|--name=                : set a application name."
    echo "  --runtime-name|--runtime-name=  : set a application runtime name."
}

function set_arguments {
    while [[ $# -gt 0 ]]
    do
        ARGS="${1}"
        shift
        case "${ARGS}" in
            "--help")
                print_help; exit;;
            "--path")
                APP_PATH="${1}"; shift;;
            "--path="*)
                APP_PATH="${ARGS#*=}";;
            "--name")
                APP_NAME="${1}"; shift;;
            "--name="*)
                APP_NAME="${ARGS#*=}";;
            "--runtime-name")
                APP_RUNTIME_NAME="${1}"; shift;;
            "--runtime-name="*)
                APP_RUNTIME_NAME="${ARGS#*=}";;
        esac
    done
}

######################################################################

APP_PATH="/svc/app/helloworld"        # default
APP_NAME="helloworld.war"             # default
APP_RUNTIME_NAME="helloworld.war"     # default
set_arguments ${@}

bash ./undeploy-app.sh --name=${APP_NAME}
bash ./deploy-app.sh --path=${APP_PATH} --name=${APP_NAME} --runtime-name=${APP_RUNTIME_NAME}
