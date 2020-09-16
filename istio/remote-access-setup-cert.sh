#!/usr/bin/bash
# https://istio.io/latest/docs/tasks/observability/gateways/

INGRESS_DOMAIN="example.com"
# INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
# INGRESS_DOMAIN=${INGRESS_HOST}.nip.io
export INGRESS_DOMAIN

CERT_DIR=/tmp/certs
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
    --key=${CERT_DIR}/tls.key \
    --cert=${CERT_DIR}/tls.crt -n istio-system 
