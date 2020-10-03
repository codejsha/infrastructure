#!/usr/bin/bash
# https://argoproj.github.io/argo-cd/getting_started/
# https://github.com/argoproj/argocd-example-apps

######################################################################

argocd app create guestbook \
    --repo https://github.com/argoproj/argocd-example-apps.git \
    --path guestbook \
    --dest-server https://10.10.10.11:6443 \
    --dest-namespace default

######################################################################

argocd app list

######################################################################

argocd app get guestbook

######################################################################

argocd app sync guestbook
argocd app set guestbook --sync-policy none
argocd app set guestbook --sync-policy automated
argocd app set guestbook --auto-prune
argocd app set guestbook --self-heal

######################################################################

argocd app delete guestbook
