#!/bin/bash

# kustomize build ./kustomize/base | kubectl apply --filename -

kustomize build https://github.com/codejsha/infrastructure/tree/main/tomcat/kustomize/base | kubectl apply --filename -
# kustomize build https://github.com/codejsha/infrastructure/tree/main/tomcat/kustomize/overlays/development | kubectl apply --filename -
# kustomize build https://github.com/codejsha/infrastructure/tree/main/tomcat/kustomize/overlays/production | kubectl apply --filename -
