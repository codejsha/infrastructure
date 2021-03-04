#!/bin/bash

curl -LJO https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x minio
sudo chown root:root minio
sudo mv minio /usr/local/bin

minio --version
