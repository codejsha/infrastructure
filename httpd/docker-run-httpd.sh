#!/usr/bin/bash
# https://hub.docker.com/_/httpd
# https://hub.docker.com/r/centos/httpd-24-centos7

docker run \
    --detach \
    --name my-httpd \
    --publish 8080:80 \
    --mount type=bind,source=/mnt/volume/httpd/htdocs,target=/usr/local/apache2/htdocs \
    httpd:2.4
