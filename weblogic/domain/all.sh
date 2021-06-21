#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

bash ./conf-domain.sh
bash ./set-domain-config-archive.sh
# bash ./set-domain-connection-filter.sh
bash ./set-domain-cookie-name.sh
bash ./set-domain-jta.sh
bash ./set-domain-log.sh
# bash ./set-domain-output-compression.sh
bash ./set-domain-restful-mgmt-service.sh
bash ./set-domain-web-app.sh
