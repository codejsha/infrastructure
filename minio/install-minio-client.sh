#!/bin/bash

curl -LJO https://dl.min.io/client/mc/release/linux-amd64/mc
chmod +x mc
sudo mv mc /usr/local/bin/mc
sudo chown root:root /usr/local/bin/mc

# mc --version
