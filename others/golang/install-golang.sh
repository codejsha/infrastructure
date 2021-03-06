#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

VERSION="1.15.6"
OS="linux"
ARCH="amd64"

curl -LJO https://golang.org/dl/go${VERSION}.${OS}-${ARCH}.tar.gz
sudo tar -C /usr/local -xzf go${VERSION}.${OS}-${ARCH}.tar.gz
rm -f https://golang.org/dl/go${VERSION}.${OS}-${ARCH}.tar.gz

# export PATH="${PATH}:/usr/local/go/bin"
