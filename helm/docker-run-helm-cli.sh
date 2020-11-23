#!/bin/bash
# https://hub.docker.com/r/alpine/helm

docker run -ti --rm -v $(pwd):/apps -v ~/.kube:/root/.kube -v ~/.helm:/root/.helm alpine/helm
### function helm() { echo "+ helm ${@}">&2; command helm ${@}; }
### alias helm="docker run -ti --rm -v $(pwd):/apps -v ~/.kube:/root/.kube -v ~/.helm:/root/.helm alpine/helm"
