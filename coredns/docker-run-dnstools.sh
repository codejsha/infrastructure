#!/bin/bash

docker run \
    --interactive \
    --tty \
    --rm \
    --name dnstools \
    infoblox/dnstools:latest
