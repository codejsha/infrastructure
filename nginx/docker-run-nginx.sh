#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

NGINX_VOLUME_HOME="/mnt/volume/nginx"
sudo mkdir -p ${NGINX_VOLUME_HOME}/{cert,conf.d,htdocs,logs}
# sudo /bin/cp -f nginx.conf ${NGINX_VOLUME_HOME}/nginx.conf
sudo /bin/cp -f reverse-proxy.conf ${NGINX_VOLUME_HOME}/conf.d/reverse-proxy.conf

######################################################################

function docker_run_nginx {
    docker container run \
        --detach \
        --name nginx \
        --publish 8080:80 \
        --mount type="bind",source="${NGINX_VOLUME_HOME}/nginx.conf",target="/etc/nginx/nginx.conf" \
        --mount type="bind",source="${NGINX_VOLUME_HOME}/cert",target="/etc/nginx/cert" \
        --mount type="bind",source="${NGINX_VOLUME_HOME}/conf.d",target="/etc/nginx/conf.d" \
        --mount type="bind",source="${NGINX_VOLUME_HOME}/htdocs",target="/usr/share/nginx/html" \
        --mount type="bind",source="${NGINX_VOLUME_HOME}/logs",target="/var/log/nginx" \
        --mount type="bind",src="/mnt/share",dst="/mnt/share",readonly \
        --mount type="bind",src="/mnt/storage",dst="/mnt/storage" \
        nginx:latest
}

function docker_run_nginx_specific_network {
    docker container run \
        --detach \
        --name nginx \
        --net minikube \
        --publish 80:80 \
        --mount type="bind",source="${NGINX_VOLUME_HOME}/nginx.conf",target="/etc/nginx/nginx.conf" \
        --mount type="bind",source="${NGINX_VOLUME_HOME}/cert",target="/etc/nginx/cert" \
        --mount type="bind",source="${NGINX_VOLUME_HOME}/conf.d",target="/etc/nginx/conf.d" \
        --mount type="bind",source="${NGINX_VOLUME_HOME}/htdocs",target="/usr/share/nginx/html" \
        --mount type="bind",source="${NGINX_VOLUME_HOME}/logs",target="/var/log/nginx" \
        --mount type="bind",src="/mnt/share",dst="/mnt/share",readonly \
        --mount type="bind",src="/mnt/storage",dst="/mnt/storage" \
        nginx:latest
}

######################################################################

docker_run_nginx
docker_run_nginx_specific_network
