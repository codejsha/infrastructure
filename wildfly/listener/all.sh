#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

### THREAD POOL

# bash ./add-thread-pool.sh --worker-name=http-worker
# bash ./add-thread-pool.sh --port-offset=0 --worker-name=http-worker
# bash ./add-thread-pool.sh --port-offset=1 --worker-name=http-worker

# bash ./add-thread-pool.sh --worker-name=https-worker
# bash ./add-thread-pool.sh --port-offset=0 --worker-name=https-worker
# bash ./add-thread-pool.sh --port-offset=1 --worker-name=https-worker

# bash ./add-thread-pool.sh --worker-name=ajp-worker
bash ./add-thread-pool.sh --port-offset=0 --worker-name=ajp-worker
bash ./add-thread-pool.sh --port-offset=1 --worker-name=ajp-worker

# bash ./set-http-listener-thread-pool.sh
bash ./set-http-listener-thread-pool.sh --port-offset=0
bash ./set-http-listener-thread-pool.sh --port-offset=1

# bash ./set-https-listener-thread-pool.sh
bash ./set-https-listener-thread-pool.sh --port-offset=0
bash ./set-https-listener-thread-pool.sh --port-offset=1

# bash ./set-ajp-listener-thread-pool.sh
bash ./set-ajp-listener-thread-pool.sh --port-offset=0
bash ./set-ajp-listener-thread-pool.sh --port-offset=1

# bash ./set-http-listener-thread-pool-config.sh
bash ./set-http-listener-thread-pool-config.sh --port-offset=0
bash ./set-http-listener-thread-pool-config.sh --port-offset=1

# bash ./set-https-listener-thread-pool-config.sh
# bash ./set-https-listener-thread-pool-config.sh --port-offset=0
# bash ./set-https-listener-thread-pool-config.sh --port-offset=1

# bash ./set-ajp-listener-thread-pool-config.sh
bash ./set-ajp-listener-thread-pool-config.sh --port-offset=0
bash ./set-ajp-listener-thread-pool-config.sh --port-offset=1

######################################################################

### TIMEOUT

# bash ./set-http-listener-timeout.sh
bash ./set-http-listener-timeout.sh --port-offset=0
bash ./set-http-listener-timeout.sh --port-offset=1

# bash ./set-https-listener-timeout.sh
bash ./set-https-listener-timeout.sh --port-offset=0
bash ./set-https-listener-timeout.sh --port-offset=1

# bash ./set-ajp-listener-timeout.sh
bash ./set-ajp-listener-timeout.sh --port-offset=0
bash ./set-ajp-listener-timeout.sh --port-offset=1

######################################################################

### HTTP METHOD

# bash ./disable-http-listener-http-method.sh
bash ./disable-http-listener-http-method.sh --port-offset=0
bash ./disable-http-listener-http-method.sh --port-offset=1

# bash ./disable-https-listener-http-method.sh
bash ./disable-https-listener-http-method.sh --port-offset=0
bash ./disable-https-listener-http-method.sh --port-offset=1

# bash ./disable-ajp-listener-http-method.sh
bash ./disable-ajp-listener-http-method.sh --port-offset=0
bash ./disable-ajp-listener-http-method.sh --port-offset=1
