#!/bin/bash
# https://kubernetes-sigs.github.io/kustomize/installation/
# https://kubernetes-sigs.github.io/kustomize/installation/binaries/
# https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh

curl -s "https://raw.githubusercontent.com/\
kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

sudo mv ./kustomize /usr/local/bin
sudo chown root:root /usr/local/bin/kustomize
