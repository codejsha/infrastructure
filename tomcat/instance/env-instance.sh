#!/bin/bash

export INSTANCE_NAME="${1:-"inst1"}"
export CATALINA_BASE="${CATALINA_HOME}/instances/${INSTANCE_NAME}"
export JVM_ROUTE="${INSTANCE_NAME}"
export APP_BASE="webapps"
export DOC_BASE=""

# export TOMCAT_ADDRESS="127.0.0.1"
export TOMCAT_ADDRESS="test.example.com"
export TOMCAT_HTTP_PORT="${2:-"8080"}"
export TOMCAT_HTTPS_PORT="${3:-"8443"}"
export TOMCAT_SHUTDOWN_PORT="${4:-"8005"}"
export TOMCAT_AJP_PORT="${5:-"8009"}"
export TOMCAT_JMX_PORT="${6:-"8050"}"

export LOG_DIR="${CATALINA_BASE}/logs"
export DUMP_LOG_DIR="${LOG_DIR}/dump"
