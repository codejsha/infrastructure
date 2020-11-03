#!/usr/bin/bash
# https://hub.docker.com/_/centos

docker run \
    --name centos8 \
    --interactive \
    --tty \
    --mount type=bind,src=/mnt/share,dst=/mnt/share \
    --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
    centos:8.2.2004

######################################################################

docker run \
    --name centos7 \
    --interactive \
    --tty \
    --mount type=bind,src=/mnt/share,dst=/mnt/share \
    --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
    centos:7.8.2003

######################################################################

docker run \
    --name centos6 \
    --interactive \
    --tty \
    --mount type=bind,src=/mnt/share,dst=/mnt/share \
    --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
    centos:6.10
