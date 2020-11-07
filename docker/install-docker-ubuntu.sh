#!/usr/bin/bash

curl -fsSL https://get.docker.com | sudo sh

sudo usermod -a -G docker ${USER}
