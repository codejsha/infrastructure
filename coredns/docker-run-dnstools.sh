#!/bin/bash

docker container run \
    --interactive \
    --tty \
    --rm \
    --name dnstools \
    infoblox/dnstools:latest
