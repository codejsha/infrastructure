#!/usr/bin/bash
# https://hub.docker.com/_/centos

docker run \
    --interactive \
    --tty \
    --name centos8 \
    --mount type=bind,src=/mnt/share,dst=/mnt/share \
    --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
    centos:8.2.2004

######################################################################

docker run \
    --interactive \
    --tty \
    --name centos7 \
    --mount type=bind,src=/mnt/share,dst=/mnt/share \
    --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
    centos:7.8.2003

######################################################################

docker run \
    --interactive \
    --tty \
    --name centos6 \
    --mount type=bind,src=/mnt/share,dst=/mnt/share \
    --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
    centos:6.10
