#!/bin/bash

sudo mkdir -p /mnt/volume/httpd/htdocs

######################################################################

function docker_run_httpd {
    docker run \
        --detach \
        --name httpd24 \
        --publish 8080:80 \
        --mount type=bind,source=/mnt/volume/httpd/htdocs,target=/usr/local/apache2/htdocs \
        --mount type=bind,src=/mnt/share,dst=/mnt/share \
        --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
        httpd:2.4
}

function docker_run_httpd_centos {
    docker run \
        --detach \
        --name httpd24 \
        --publish 8080:80 \
        --mount type=bind,source=/mnt/volume/httpd/htdocs,target=/var/www/html \
        --mount type=bind,src=/mnt/share,dst=/mnt/share \
        --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
        centos/httpd-24-centos7:2.4
}

######################################################################

# docker_run_httpd
docker_run_httpd_centos
