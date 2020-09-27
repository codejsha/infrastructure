#!/usr/bin/bash

docker run \
    --rm \
    --name dnstools \
    --interactive \
    --tty \
    infoblox/dnstools:latest
