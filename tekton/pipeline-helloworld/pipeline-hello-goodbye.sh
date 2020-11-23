#!/bin/bash
# https://tekton.dev/docs/getting-started/

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

kubectl apply -f pipeline-hello-goodbye.yaml

tkn pipeline start hello-goodbye --dry-run
tkn pipeline start hello-goodbye
# tkn pipeline start hello-goodbye --dry-run > pipelineRun-hello-goodbye.yaml
# kubectl create -f pipelineRun-hello-goodbye.yaml

tkn pipelinerun logs --last -f 
