#!/bin/bash

### requirement:
### git

(
    set -x; cd "$(mktemp -d)" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&
    tar zxvf krew.tar.gz &&
    KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" &&
    "$KREW" install krew
)

### add path
# PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# export PATH
