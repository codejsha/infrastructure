#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

minikube start \
    --nodes 4 \
    --addons metallb \
    --addons ingress \
    --addons ingress-dns \
    --addons istio-provisioner \
    --addons istio \
    --addons dashboard \
    --addons metrics-server \
    --addons efk \
    --addons default-storageclass \
    --addons storage-provisioner \
    --addons logviewer \
    --addons registry \
    --addons registry-aliases

    # --addons ambassador \
    # --addons csi-hostpath-driver \
    # --addons freshpod \
    # --addons gcp-auth \
    # --addons gvisor \
    # --addons helm-tiller \
    # --addons kubevirt \
    # --addons nvidia-driver-installer \
    # --addons nvidia-gpu-device-plugin \
    # --addons olm \
    # --addons pod-security-policy \
    # --addons registry-creds \
    # --addons storage-provisioner-gluster \
    # --addons volumesnapshots \
