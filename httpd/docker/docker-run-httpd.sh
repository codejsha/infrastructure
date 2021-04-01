#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

HTTPD_VOLUME_DIR="/mnt/volume/httpd"
sudo mkdir -p ${HTTPD_VOLUME_DIR}/{conf,htdocs}
# sudo /bin/cp -f docker-httpd.conf ${HTTPD_VOLUME_DIR}/conf/httpd.conf

######################################################################

function docker_run_httpd {
    docker container run \
        --detach \
        --name httpd \
        --publish 8080:80 \
        --mount type="bind",source="${HTTPD_VOLUME_DIR}/conf",target="/usr/local/apache2/conf" \
        --mount type="bind",source="${HTTPD_VOLUME_DIR}/htdocs",target="/usr/local/apache2/htdocs" \
        --mount type="bind",src="/mnt/share",dst="/mnt/share",readonly \
        --mount type="bind",src="/mnt/storage",dst="/mnt/storage" \
        httpd:2.4
}

######################################################################

docker_run_httpd
