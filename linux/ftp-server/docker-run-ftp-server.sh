#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

docker container run \
    --detach \
    --name ftp-server \
    --publish 21:21 \
    --publish 10400-10410:10400-10410 \
    --mount type="bind",src="/mnt/share",dst="/var/ftp/pub" \
    ftp-server /bin/bash -c '/usr/sbin/vsftpd && tail -f /dev/null'
