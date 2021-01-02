#!/bin/bash

######################################################################

### THREAD POOL

# bash ./add-thread-pool.sh
bash ./add-thread-pool.sh --port-offset=0
bash ./add-thread-pool.sh --port-offset=1

# bash ./set-http-listener-thread-pool.sh
# bash ./set-http-listener-thread-pool.sh --port-offset=0
# bash ./set-http-listener-thread-pool.sh --port-offset=1

# bash ./set-ajp-listener-thread-pool.sh
bash ./set-ajp-listener-thread-pool.sh --port-offset=0
bash ./set-ajp-listener-thread-pool.sh --port-offset=1

######################################################################

### TIMEOUT

# bash ./set-http-listener-timeout.sh
bash ./set-http-listener-timeout.sh --port-offset=0
bash ./set-http-listener-timeout.sh --port-offset=1

# bash ./set-ajp-listener-timeout.sh
bash ./set-ajp-listener-timeout.sh --port-offset=0
bash ./set-ajp-listener-timeout.sh --port-offset=1
