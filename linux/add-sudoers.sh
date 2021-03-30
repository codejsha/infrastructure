#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

# sudo sed -i -E '/^root\tALL=\(ALL\) \tALL$/ a prouser\tALL=(ALL) \tALL' /etc/sudoers
sudo sed -i -E '/^root\tALL=\(ALL\) \tALL$/ a prouser\tALL=(ALL) \tNOPASSWD:ALL' /etc/sudoers
