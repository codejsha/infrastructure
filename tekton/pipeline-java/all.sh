#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

export ARGOCD_USERNAME="${ARGOCD_USERNAME}"
export ARGOCD_PASSWORD="${ARGOCD_PASSWORD}"
export ARGOCD_AUTH_TOKEN="${ARGOCD_AUTH_TOKEN}"

export GITLAB_CD_USERNAME="${GITLAB_CD_USERNAME}"
export GITLAB_CD_PASSWORD="${GITLAB_CD_PASSWORD}"
export GITLAB_CI_SECRET_TOKEN="${GITLAB_CI_SECRET_TOKEN}"

envsubst < ./argocd-secret.yaml > ./argocd-secret-temp.yaml
envsubst < ./gitlab-cd-secret.yaml > ./gitlab-cd-secret-temp.yaml
envsubst < ./gitlab-ci-secret.yaml > ./gitlab-ci-secret-temp.yaml

kubectl config set-context --current --namespace=myproject

kubectl apply --filename https://raw.githubusercontent.com/tektoncd/catalog/master/task/git-clone/0.2/git-clone.yaml
kubectl apply --filename https://raw.githubusercontent.com/tektoncd/catalog/master/task/maven/0.2/maven.yaml
# kubectl apply --filename https://raw.githubusercontent.com/tektoncd/catalog/master/task/kaniko/0.1/kaniko.yaml
kubectl apply --filename kaniko-0.1-custom-task.yaml
# kubectl apply --filename https://raw.githubusercontent.com/tektoncd/catalog/master/task/kubernetes-actions/0.1/kubernetes-actions.yaml
kubectl apply --filename kustomize-cli-task.yaml
kubectl apply --filename https://raw.githubusercontent.com/tektoncd/catalog/master/task/git-cli/0.1/git-cli.yaml
kubectl apply --filename https://raw.githubusercontent.com/tektoncd/catalog/master/task/argocd-task-sync-and-wait/0.1/argocd-task-sync-and-wait.yaml

kubectl apply --filename docker-configmap.yaml
kubectl apply --filename maven-configmap.yaml
kubectl apply --filename input-asset-configmap.yaml
kubectl apply --filename kube-configmap.yaml
kubectl apply --filename argocd-configmap.yaml
kubectl apply --filename argocd-secret-temp.yaml
kubectl apply --filename gitlab-cd-secret-temp.yaml
kubectl apply --filename gitlab-cd-serviceaccount.yaml
kubectl apply --filename gitlab-ci-secret-temp.yaml
kubectl apply --filename gitlab-ci-serviceaccount.yaml
kubectl apply --filename gitlab-ci-role.yaml
kubectl apply --filename gitlab-ci-rolebinding.yaml
kubectl apply --filename gitlab-trigger.yaml
kubectl apply --filename gitlab-eventlistener-ingress.yaml
kubectl apply --filename pvc.yaml
kubectl apply --filename pipeline.yaml
