#!/bin/bash
# https://hub.docker.com/_/httpd
# https://hub.docker.com/r/centos/httpd-24-centos7

sudo mkdir -p /mnt/volume/httpd/htdocs

docker run \
    --detach \
    --name httpd24 \
    --publish 8080:80 \
    --mount type=bind,source=/mnt/volume/httpd/htdocs,target=/usr/local/apache2/htdocs \
    --mount type=bind,src=/mnt/share,dst=/mnt/share \
    --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
    httpd:2.4
