#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

SCOUTER_PAPER_VERSION="2.6.4"

curl -LJO https://github.com/scouter-contrib/scouter-paper/releases/download/${SCOUTER_PAPER_VERSION}/scouter-paper-v${SCOUTER_PAPER_VERSION}.zip
