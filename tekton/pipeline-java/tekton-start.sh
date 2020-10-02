#!/usr/bin/bash

kubectl config set-context --current --namespace=tekton-pipelines

kubectl apply --filename https://raw.githubusercontent.com/tektoncd/catalog/master/task/git-clone/0.2/git-clone.yaml
kubectl apply --filename https://raw.githubusercontent.com/tektoncd/catalog/master/task/maven/0.2/maven.yaml
# kubectl apply --filename https://raw.githubusercontent.com/tektoncd/catalog/master/task/kaniko/0.1/kaniko.yaml
kubectl apply --filename kaniko-0.1-custom.yaml
kubectl apply --filename verify-image-digest.yaml
# kubectl apply --filename https://raw.githubusercontent.com/tektoncd/catalog/master/task/kubernetes-actions/0.1/kubernetes-actions.yaml
kubectl apply --filename kustomize-cli-task.yaml
kubectl apply --filename https://raw.githubusercontent.com/tektoncd/catalog/master/task/git-cli/0.1/git-cli.yaml

# kubectl apply --filename github-secret.yaml
# kubectl apply --filename github-serviceaccount.yaml

kubectl apply --filename gitlab-secret.yaml
kubectl apply --filename gitlab-serviceaccount.yaml
kubectl apply --filename gitlab-role.yaml
kubectl apply --filename gitlab-rolebinding.yaml
kubectl apply --filename gitlab-trigger.yaml
kubectl apply --filename gitlab-eventlistener-ingress.yaml

kubectl apply --filename docker-configmap.yaml
kubectl apply --filename maven-configmap.yaml
kubectl apply --filename input-asset-configmap.yaml
kubectl apply --filename kube-configmap.yaml
kubectl apply --filename pvc.yaml
kubectl apply --filename java-pipeline.yaml

# kubectl create --filename run.yaml
# tkn pipelineruns logs --follow --last
