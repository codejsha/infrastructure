# Argo CD

https://argoproj.github.io/projects/argo-cd

## Install

```bash
bash install-argocd.sh
bash install-argocd-cli.sh
kubectl apply --filename argocd-server-ingress.yaml
```

## Change password

```bash
bash change-password.sh
```

## Register cluster

```bash
bash register-cluster.sh
```

## Login/Logout

```bash
bash login-server.sh
bash logout-server.sh
```

## Project

### yaml

- [project.yaml](/argoproj/argocd/project.yaml) (https://raw.githubusercontent.com/argoproj/argo-cd/master/docs/operator-manual/project.yaml)
- [appproj.yaml](/tekton/pipeline-java/appproj.yaml) in tekton java pipeline

### command

- [create-proj.sh](/argoproj/argocd/create-proj.sh)
- [create-role.sh](/argoproj/argocd/create-role.sh)

## App

### yaml

- [application.yaml](/argoproj/argocd/application.yaml) (https://raw.githubusercontent.com/argoproj/argo-cd/master/docs/operator-manual/application.yaml)
- [app.yaml](/tekton/pipeline-java/app.yaml) in tekton java pipeline

### command

- [argocd-app-commands.sh](/argoproj/argocd/argocd-app-commands.sh)
