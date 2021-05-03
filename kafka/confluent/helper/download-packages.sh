#!/bin/bash

### linux
pip3 download --requirement requirements.txt --dest packages --platform manylinux1_x86_64

### windows
pip3 download --requirement requirements.txt --dest packages --platform win_amd64
