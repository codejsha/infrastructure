#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

HTTPD_VOLUME_HOME="/mnt/volume/httpd"
sudo mkdir -p ${HTTPD_VOLUME_HOME}/{conf, htdocs}
sudo /bin/cp -f docker-httpd.conf ${HTTPD_VOLUME_HOME}/conf/httpd.conf

######################################################################

function docker_run_httpd {
    docker container run \
        --detach \
        --name httpd24 \
        --publish 8080:80 \
        --mount type="bind",source="${HTTPD_VOLUME_HOME}/conf",target="/usr/local/apache2/conf" \
        --mount type="bind",source="${HTTPD_VOLUME_HOME}/htdocs",target="/usr/local/apache2/htdocs" \
        --mount type="bind",src="/mnt/share",dst="/mnt/share" \
        --mount type="bind",src="/mnt/storage",dst="/mnt/storage" \
        httpd:2.4
}

######################################################################

docker_run_httpd
