#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
# https://tekton.dev/docs/getting-started/

cat <<EOF > ./task-goodbye.yaml
apiVersion: tekton.dev/v1beta1
kind: Task
metadata:
  name: goodbye
spec:
  steps:
    - name: goodbye
      image: ubuntu
      script: |
        #!/bin/bash
        echo "Goodbye World!"
EOF

kubectl apply --filename task-goodbye.yaml

tkn task start goodbye --dry-run
tkn task start goodbye
# tkn task start goodbye --dry-run > taskRun-goodbye.yaml
# kubectl create --filename taskRun-goodbye.yaml

tkn taskrun logs --follow --last
