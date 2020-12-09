#!/bin/bash

docker build --tag registry.example.com/kustomize-cli:latest .
docker push registry.example.com/kustomize-cli:latest

# docker build --tag core.harbor.example.com/kustomize-cli:latest .
# docker push core.harbor.example.com/kustomize-cli:latest
