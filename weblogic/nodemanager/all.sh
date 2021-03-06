#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

### CREATE NODE MANAGER
### bash ./create-nodemgr.sh ${NODEMGR_NAME}

bash ./create-nodemgr.sh BaseMachine1
# bash ./create-nodemgr.sh BaseMachine2

######################################################################

### CHANGE NODE MANAGER PASSWORD
### bash ./change-nodemgr-password.sh
### bash ./change-nodemgr-password.sh ${NEW_USERNAME} ${NEW_PASSWORD}

# bash ./change-nodemgr-password.sh
bash ./change-nodemgr-password.sh weblogic welcome1

######################################################################

### CONFIGURE NODE MANAGER
### bash ./set-nodemgr-config.sh ${NODEMGR_NAME} ${NODEMGR_ADDRESS} ${NODEMGR_PORT}

bash ./set-nodemgr-config.sh BaseMachine1 test.example.com 5556
# bash ./set-nodemgr-config.sh BaseMachine2 test.example.com 5557

######################################################################

### CREATE SCRIPTS
### bash ./create-nodemgr-scripts.sh ${NODEMGR_NAME} ${NODEMGR_ADDRESS} ${NODEMGR_PORT}

bash ./create-nodemgr-scripts.sh BaseMachine1 test.example.com 5556
# bash ./create-nodemgr-scripts.sh BaseMachine2 test.example.com 5557
