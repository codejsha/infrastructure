#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

USER_ID="1000"
USER_NAME="prouser"
GROUP_ID="1000"
GROUP_NAME="progroup"
HOME_DIRECTORY="/home/prouser"
PASSWORD="${PASSWORD}"

######################################################################

function add_group {
    groupadd --gid ${GROUP_ID} ${GROUP_NAME}
}

function add_user_with_group {
    useradd --uid ${USER_ID} --gid ${GROUP_ID} --create-home --home-dir ${HOME_DIRECTORY} ${USER_NAME} --shell /bin/bash
}

function add_user_with_usergroup {
    useradd --uid ${USER_ID} --user-group --create-home --home-dir ${HOME_DIRECTORY} ${USER_NAME} --shell /bin/bash
}

function add_user_with_password {
    useradd --uid ${USER_ID} --gid ${GROUP_ID} --create-home --home-dir ${HOME_DIRECTORY} ${USER_NAME} --password ${PASSWORD} --shell /bin/bash
}

######################################################################

add_group
add_user_with_group
# add_user_with_usergroup
# add_user_with_password
