#!/bin/bash

minikube start \
    --addons ambassador \
    --addons metrics-server \
    --addons dashboard \
    --addons default-storageclass \
    --addons efk \
    --addons ingress \
    --addons ingress-dns \
    --addons istio-provisioner \
    --addons istio \
    --addons logviewer \
    --addons metallb \
    --addons olm \
    --addons registry \
    --addons registry-aliases \
    --addons storage-provisioner \

    # --addons csi-hostpath-driver \
    # --addons freshpod \
    # --addons gcp-auth \
    # --addons gvisor \
    # --addons helm-tiller \
    # --addons kubevirt \
    # --addons nvidia-driver-installer \
    # --addons nvidia-gpu-device-plugin \
    # --addons pod-security-policy \
    # --addons registry-creds \
    # --addons storage-provisioner-gluster \
    # --addons volumesnapshots
