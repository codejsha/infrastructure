#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

### Log levels:
### ALL, CONFIG, DEBUG, ERROR, FATAL, FINE, FINER, FINEST, INFO, OFF, SEVERE, TRACE, WARN, WARNING

source ../env-base.sh

######################################################################

function set_logging {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
<<EOF
batch
/subsystem=logging/console-handler=CONSOLE:write-attribute(name=encoding,value=UTF-8)
/subsystem=logging/periodic-rotating-file-handler=FILE:write-attribute(name=encoding,value=UTF-8)

/subsystem=logging/root-logger=ROOT:write-attribute(name=level,value=INFO)
run-batch
quit
EOF
}

function reload_server {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
        --echo-command \
        --command=":reload()"
}

##############################################s########################

set_logging
reload_server
