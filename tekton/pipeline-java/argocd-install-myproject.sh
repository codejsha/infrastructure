#!/usr/bin/bash

argocd app create myproject \
    --repo http://gitlab.example.com:9480/root/myproject-cd.git \
    --path base \
    --dest-server https://192.168.140.11:6443 \
    --dest-namespace myproject

# argocd app sync guestbook