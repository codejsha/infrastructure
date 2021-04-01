#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

cat <<EOF > ./task-hello.yaml
apiVersion: tekton.dev/v1beta1
kind: Task
metadata:
  name: hello
spec:
  steps:
    - name: hello
      image: ubuntu
      command:
        - echo
      args:
        - "Hello World!"
EOF

kubectl apply --filename task-hello.yaml

tkn task start hello --dry-run
tkn task start hello
# tkn task start hello --dry-run > taskRun-hello.yaml
# kubectl create --filename taskRun-hello.yaml

tkn taskrun logs --follow --last
