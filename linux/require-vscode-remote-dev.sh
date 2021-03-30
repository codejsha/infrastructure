#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

### https://code.visualstudio.com/docs/remote/linux
### https://code.visualstudio.com/docs/remote/troubleshooting

sudo yum install -y glibc libgcc libstdc++ python3 ca-certificates tar

# export USER_AT_HOST="your-user-name-on-host@hostname"
# export PUBKEYPATH="${HOME}/.ssh/id_rsa.pub"
# ssh-copy-id -i "${PUBKEYPATH}" "${USER_AT_HOST}"
# chmod 600 ${HOME}/.ssh/authorized_keys
