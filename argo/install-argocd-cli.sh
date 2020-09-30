#!/usr/bin/bash
# https://github.com/argoproj/argo-cd

ARGOCD_VERSION="v1.7.7"

sudo curl -o /usr/local/bin/argocd -LJO https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_VERSION}/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd

argocd version
