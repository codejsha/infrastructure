#!/bin/bash

SERVER_NAME=""
LOG_DIR=""

tail -f ${LOG_DIR}/nohup.${SERVER_NAME}.out ${@}
