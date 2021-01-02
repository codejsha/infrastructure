#!/bin/bash

# bash ./add-access-log.sh
bash ./add-access-log.sh --port-offset=0
bash ./add-access-log.sh --port-offset=1

# bash ./set-logging.sh
bash ./set-logging.sh --port-offset=0
bash ./set-logging.sh --port-offset=1
