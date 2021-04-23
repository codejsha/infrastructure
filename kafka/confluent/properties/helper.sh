#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

######################################################################

function replace_variable_zookeeper {
    local START_SCRIPT_NAME="${1}"
    local DATA_DIR="${2}"

    ### escape forward slash
    local DATA_DIR="${DATA_DIR//\//\\/}"

    perl -pi -e "s/^dataDir=.*/dataDir=${DATA_DIR}/g" ${START_SCRIPT_NAME}
}

function replace_variable_kafka {
    local START_SCRIPT_NAME="${1}"
    local DATA_DIR="${2}"

    ### escape forward slash
    local DATA_DIR="${DATA_DIR//\//\\/}"

    perl -pi -e "s/^log.dirs=.*/log.dirs=${DATA_DIR}/g" ${START_SCRIPT_NAME}
}

function replace_variable_ksqldb {
    local START_SCRIPT_NAME="${1}"
    local DATA_DIR="${2}"

    ### escape forward slash
    local DATA_DIR="${DATA_DIR//\//\\/}"

    perl -pi -e "s/^state.dir=.*/state.dir=${DATA_DIR}/g" ${START_SCRIPT_NAME}
}

function replace_variable_control_center {
    local START_SCRIPT_NAME="${1}"
    local DATA_DIR="${2}"
    local PLUGIN_PATH="${3}"

    ### escape forward slash
    local DATA_DIR="${DATA_DIR//\//\\/}"
    local PLUGIN_PATH="${PLUGIN_PATH//\//\\/}"

    perl -pi -e "s/^confluent.controlcenter.data.dir=.*/confluent.controlcenter.data.dir=${DATA_DIR}/g" ${START_SCRIPT_NAME}
    perl -pi -e "s/^plugin.path=.*/plugin.path=${PLUGIN_PATH}/g" ${START_SCRIPT_NAME}
}

######################################################################

### zookeeper
DATA_DIR="/mnt/zookeeper/data"
# DATA_DIR="/var/lib/zookeeper"
replace_variable_zookeeper "zookeeper*.properties" ${DATA_DIR}

### kafka
DATA_DIR="/mnt/kafka/data"
# DATA_DIR="/var/lib/kafka"
replace_variable_kafka "kafka*.properties" ${DATA_DIR}

### ksqldb
DATA_DIR="/mnt/ksqldb/data"
# DATA_DIR="/var/lib/kafka-streams"
replace_variable_ksqldb "ksql-server*.properties" ${DATA_DIR}

### control-center
DATA_DIR="/mnt/control-center/data"
# DATA_DIR="/var/lib/confluent/control-center"
PLUGIN_PATH="/usr/local/confluent/share/java,/usr/local/confluent/share/confluent-hub-components"
# PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components"
replace_variable_control_center "control-center*.properties" ${DATA_DIR} ${PLUGIN_PATH}
