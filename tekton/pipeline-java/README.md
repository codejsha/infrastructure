# Java Pipeline

## Workflow

```txt
Push event ---> Event trigger ---> CI/CD
```

## Event trigger

```txt
gitlab-ci-listener ---> gitlab-push-binding ---> gitlab-java-template
 (EventListener)         (TriggerBinding)         (TriggerTemplate)
```

## CI/CD

```txt
pipelinerun-java-xxxxx ---> java-pipeline
    (PipelineRun)            (Pipeline)
```

Tasks in java-pipeline:

```txt
clone-ci-repo ---> build-source ---> build-image
                                         |
      ------------------------------------
      |
      V
clone-cd-repo ---> kustomize-cd-repo ---> commit-cd-repo
                                                 |
    ----------------------------------------------
    |
    V
sync-app
```

## Kustomize

File structure:

```txt
kustomize
├── base
│   ├── deployment.yaml
│   ├── ingress.yaml
│   ├── kustomization.yaml
│   └── service.yaml
└── overlays
    ├── development
    │   └── kustomization.yaml
    └── production
        └── kustomization.yaml
```

Resource structure:

```txt
kustomize
└── base
    ├── [deployment.yaml]  Deployment starter
    ├── [ingress.yaml]  Ingress starter
    ├── [kustomization.yaml]  Kustomization
    └── [service.yaml]  Service starter
```

## Application details

```txt
Name:               myproject
Project:            myproject
Server:             https://10.10.10.11:6443
Namespace:          myproject
URL:                https://argocd.example.com/applications/myproject
Repo:               http://gitlab.example.com:9480/root/myproject-cd.git
Target:             HEAD
Path:               base
SyncWindow:         Sync Allowed
Sync Policy:        Automated (Prune)
Sync Status:        Synced to HEAD (3ec1d74)
Health Status:      Healthy

GROUP              KIND        NAMESPACE  NAME     STATUS  HEALTH   HOOK  MESSAGE
                   Service     myproject  starter  Synced  Healthy        service/starter created
apps               Deployment  myproject  starter  Synced  Healthy        deployment.apps/starter created
networking.k8s.io  Ingress     myproject  starter  Synced  Healthy        ingress.networking.k8s.io/starter created
```
