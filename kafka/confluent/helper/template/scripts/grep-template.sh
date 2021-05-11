#!/bin/bash

SERVER_NAME=""
LOG_DIR=""

grep --color ${@} ${LOG_DIR}/nohup.${SERVER_NAME}.out
