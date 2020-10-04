#!/usr/bin/bash

argocd app create myproject \
    --project myproject \
    --repo http://gitlab.example.com:9480/root/myproject-cd.git \
    --path base \
    --dest-server https://10.10.10.11:6443 \
    --dest-namespace myproject

# argocd app get myproject
# argocd app sync myproject
# argocd app delete myproject