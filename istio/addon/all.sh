#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

bash ./install-addon.sh
bash ./remote-access-setup-cert.sh
bash ./remote-access-grafana.sh
bash ./remote-access-kiali.sh
bash ./remote-access-prometheus.sh
bash ./remote-access-tracing.sh
