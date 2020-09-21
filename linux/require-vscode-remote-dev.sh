#!/usr/bin/bash
# https://code.visualstudio.com/docs/remote/linux
# https://code.visualstudio.com/docs/remote/troubleshooting

sudo yum install -y glibc libgcc libstdc++ python ca-certificates tar

# export USER_AT_HOST="your-user-name-on-host@hostname"
# export PUBKEYPATH="${HOME}/.ssh/id_rsa.pub"
# ssh-copy-id -i "${PUBKEYPATH}" "${USER_AT_HOST}"

chmod 600 ${HOME}/.ssh/authorized_keys
