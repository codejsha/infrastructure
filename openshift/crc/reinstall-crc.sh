#!/bin/bash

crc delete
crc cleanup
crc setup
./crc start --pull-secret-file ~/pull-secret.txt
