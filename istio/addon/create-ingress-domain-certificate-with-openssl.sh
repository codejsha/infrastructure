#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

INGRESS_DOMAIN="example.com"
# INGRESS_HOST=$(kubectl get service istio-ingressgateway --namespace istio-system --output jsonpath='{.status.loadBalancer.ingress[0].ip}')
# INGRESS_DOMAIN=${INGRESS_HOST}.nip.io
export INGRESS_DOMAIN

CERT_DIR="./certs"
mkdir -p ${CERT_DIR}

openssl req \
    -x509 \
    -sha256 \
    -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -subj '/O=example Inc./CN=*.${INGRESS_DOMAIN}' \
    -keyout ${CERT_DIR}/ca.key \
    -out ${CERT_DIR}/ca.crt
openssl req \
    -out ${CERT_DIR}/cert.csr \
    -newkey rsa:2048 \
    -nodes \
    -keyout ${CERT_DIR}/tls.key \
    -subj "/CN=*.${INGRESS_DOMAIN}/O=example organization"
openssl x509 -req \
    -days 365 \
    -CA ${CERT_DIR}/ca.crt \
    -CAkey ${CERT_DIR}/ca.key \
    -set_serial 0 \
    -in ${CERT_DIR}/cert.csr \
    -out ${CERT_DIR}/tls.crt
kubectl create secret tls telemetry-gw-cert \
    --namespace istio-system \
    --key=${CERT_DIR}/tls.key \
    --cert=${CERT_DIR}/tls.crt
