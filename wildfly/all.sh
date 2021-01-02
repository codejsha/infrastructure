#!/bin/bash

# bash ./create-instance.sh
bash ./create-instance.sh --instance=inst1
bash ./create-instance.sh --instance=inst2

# bash create-scripts.sh
bash create-scripts.sh --instance=inst1 --port-offset=0
bash create-scripts.sh --instance=inst2 --port-offset=1
