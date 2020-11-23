#!/bin/bash

docker build --tag registry.example.com/kustomize-cli:latest .
docker push registry.example.com/kustomize-cli:latest
