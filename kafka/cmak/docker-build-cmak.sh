#!/bin/bash

# docker image build --tag registry.example.com/cmak:latest .
# docker image push registry.example.com/cmak:latest

docker image build --tag core.harbor.example.com/library/cmak:latest .
docker image push core.harbor.example.com/library/cmak:latest
