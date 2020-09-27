#!/usr/bin/bash

VERSION="1.15"
OS="linux"
ARCH="amd64"

curl -LJO https://golang.org/dl/go${VERSION}.${OS}-${ARCH}.tar.gz
sudo tar -C /usr/local -xzf go${VERSION}.${OS}-${ARCH}.tar.gz
export PATH="${PATH}:/usr/local/go/bin"
