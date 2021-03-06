#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

######################################################################

### EXAMPLE FILTER

# bash ./add-filter.sh
# bash ./add-filter.sh --port-offset=0
# bash ./add-filter.sh --port-offset=1

######################################################################

### SAMESITE FILTER

# bash ./add-samesite-filter.sh
bash ./add-samesite-filter.sh --port-offset=0
bash ./add-samesite-filter.sh --port-offset=1

######################################################################

### STUCK THREAD DETECTOR

# bash ./add-stuck-thread-detector.sh
bash ./add-stuck-thread-detector.sh --port-offset=0
bash ./add-stuck-thread-detector.sh --port-offset=1

######################################################################

### HIDE SERVER HEADER INFO (Server, X-Powered-By)

# bash ./hide-server-header-info.sh
bash ./hide-server-header-info.sh --port-offset=0
bash ./hide-server-header-info.sh --port-offset=1
