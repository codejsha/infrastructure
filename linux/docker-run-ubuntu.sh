#!/usr/bin/bash
# https://hub.docker.com/_/ubuntu

docker run \
    --interactive \
    --tty \
    --name ubuntu20 \
    --mount type=bind,src=/mnt/share,dst=/mnt/share \
    --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
    ubuntu:20.04
