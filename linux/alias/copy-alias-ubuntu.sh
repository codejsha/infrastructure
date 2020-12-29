#!/bin/bash

rm -rf ~/.aliases

/usr/bin/cp -f .bashrc_ubuntu ~/.bashrc
/usr/bin/cp -rf aliases ~/.aliases

curl -o ~/.aliases/.kubectl_aliases -LJO https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases
