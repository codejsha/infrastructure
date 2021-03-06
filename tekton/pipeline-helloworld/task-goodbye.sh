#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
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

kubectl apply -f task-goodbye.yaml

tkn task start goodbye --dry-run
tkn task start goodbye
# tkn task start goodbye --dry-run > taskRun-goodbye.yaml
# kubectl create -f taskRun-goodbye.yaml

tkn taskrun logs --last -f
