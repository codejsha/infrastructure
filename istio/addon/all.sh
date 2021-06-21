#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

bash ./install-addon.sh

######################################################################

bash ./create-ingress-domain-certificate.sh
# bash ./create-ingress-domain-certificate-with-openssl.sh

######################################################################

# bash ./create-ingress-domain-cert.sh
# bash ./remote-access-grafana.sh
# bash ./remote-access-kiali.sh
# bash ./remote-access-prometheus.sh
# bash ./remote-access-tracing.sh
