#!/bin/bash

######################################################################

# bash ./set-tcp-clustering.sh
# bash ./set-tcp-clustering.sh --port-offset=0
# bash ./set-tcp-clustering.sh --port-offset=1

# bash ./set-ucp-clustering.sh
bash ./set-ucp-clustering.sh --port-offset=0
bash ./set-ucp-clustering.sh --port-offset=1

######################################################################

# bash ./check-clustering.sh
bash ./check-clustering.sh --port-offset=0
bash ./check-clustering.sh --port-offset=1
