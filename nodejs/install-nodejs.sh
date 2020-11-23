#!/bin/bash
# https://github.com/nodesource/distributions/blob/master/README.md

### As root
# curl -sL https://rpm.nodesource.com/setup_lts.x | bash -
### No root privileges
curl -sL https://rpm.nodesource.com/setup_lts.x | sudo bash -

sudo yum remove -y nodejs npm
sudo yum install -y nodejs

### to build native addons
# sudo yum install -y gcc-c++ make
