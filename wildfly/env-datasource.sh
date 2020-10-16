#!/usr/bin/bash

DATASOURCE_NAME="baseds1"
JNDI_NAME="java:/base/ds1"
ENABLED="true"
CONNECTION_URL="jdbc:oracle:thin:@192.168.137.1:1521:orclcdb"
MIN_POOL_SIZE="10"
MAX_POOL_SIZE="10"
USERNAME="system"
PASSWORD="\${VAULT::datasource::password::1}"
