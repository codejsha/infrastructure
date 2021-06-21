#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

cat <<EOF > ./pipeline-hello-goodbye.yaml
apiVersion: tekton.dev/v1beta1
kind: Pipeline
metadata:
  name: hello-goodbye
spec:
  tasks:
    - name: hello
      taskRef:
        name: hello
    - name: goodbye
      runAfter:
       - hello
      taskRef:
        name: goodbye
EOF

kubectl apply --filename pipeline-hello-goodbye.yaml

tkn pipeline start hello-goodbye --dry-run
tkn pipeline start hello-goodbye
# tkn pipeline start hello-goodbye --dry-run > pipelineRun-hello-goodbye.yaml
# kubectl create --filename pipelineRun-hello-goodbye.yaml

tkn pipelinerun logs --follow --last
