#!/bin/bash

# kustomize build ./kustomize/base | kubectl apply --filename -

kustomize build https://github.com/codejsha/infrastructure/tomcat/kustomize/base | kubectl apply --filename -
# kustomize build https://github.com/codejsha/infrastructure/tomcat/kustomize/overlays/development | kubectl apply --filename -
# kustomize build https://github.com/codejsha/infrastructure/tomcat/kustomize/overlays/prodction | kubectl apply --filename -
