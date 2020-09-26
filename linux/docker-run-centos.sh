#!/usr/bin/bash
# https://hub.docker.com/_/centos

docker run \
    --name centos8 \
    --interactive \
    --tty \
    centos:8.2.2004

######################################################################

docker run \
    --name centos7 \
    --interactive \
    --tty \
    centos:7.8.2003

######################################################################

docker run \
    --name centos6 \
    --interactive \
    --tty \
    centos:6.10
