#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

oc new-project bookinfo

oc apply --filename smcp.yaml
oc apply --filename smmr.yaml
oc apply --namespace bookinfo --filename https://raw.githubusercontent.com/Maistra/istio/maistra-1.1/samples/bookinfo/platform/kube/bookinfo.yaml
oc apply --namespace bookinfo --filename https://raw.githubusercontent.com/Maistra/istio/maistra-1.1/samples/bookinfo/networking/bookinfo-gateway.yaml
oc apply --namespace bookinfo --filename https://raw.githubusercontent.com/Maistra/istio/maistra-1.1/samples/bookinfo/networking/destination-rule-all.yaml

### verify
# export GATEWAY_URL=$(oc --namespace istio-system get route istio-ingressgateway --output jsonpath='{.spec.host}')
# curl -o /dev/null -s -w "%{http_code}\n" http://$GATEWAY_URL/productpage
### 200

### delete
# oc delete project bookinfo
# oc patch smmr default --namespace istio-system --type='json' --patch '[{"op": "remove", "path": "/spec/members", "value":["'"bookinfo"'"]}]'
