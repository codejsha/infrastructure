#!/bin/bash

# docker image build --tag registry.example.com/example-repo-server:latest .
# docker image push registry.example.com/example-repo-server:latest

docker image build --tag core.harbor.example.com/library/example-repo-server:latest .
docker image push core.harbor.example.com/library/example-repo-server:latest
