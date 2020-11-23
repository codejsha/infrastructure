#!/bin/bash

INSTALL_FILE_DIR="/mnt/share/oracle-iplanet-web-server/Oracle-iPlanet-Web-Server-7.0.27-linux-x64"
INSTALL_SCRIPT_DIR="/svc/infrastructure/iplanet"

${INSTALL_FILE_DIR}/setup --silent ${INSTALL_SCRIPT_DIR}/statefile
