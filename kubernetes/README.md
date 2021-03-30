# Kubernetes

## Install

### Kubespray

[Installing Kubernetes with Kubespray README](/kubernetes/kubespray/README.md)

### kind

- https://kind.sigs.k8s.io/
- https://github.com/kubernetes-sigs/kind/

```bash
bash ./install-kind.sh
bash ./create-cluster.sh
```

### minikube

- https://minikube.sigs.k8s.io/docs/
- https://github.com/kubernetes/minikube

```bash
bash ./install-minikube.sh
bash ./start-minikube.sh
```

## CLI Tools

### kubectl

- https://kubernetes.io/docs/tasks/tools/install-kubectl

```bash
bash ./install-kubectl.sh
```

### kubectl-aliases

- https://github.com/ahmetb/kubectl-aliases

```bash
bash ./install-kubectl-aliases.sh
```

### Krew

- https://krew.sigs.k8s.io/

```bash
bash ./install-krew.sh
bash ./install-krew-plugins.sh
```

## Linux daemon

### Docker

- `/etc/systemd/system/docker.service`
- `/etc/systemd/system/docker.service.d/docker-options.conf`
- `/etc/systemd/system/docker.service.d/docker-dns.conf`

### ETCD

- `/etc/systemd/system/etcd.service`
- `/etc/etcd.env`

### Kubelet

- `/etc/systemd/system/kubelet.service`
- `/etc/kubernetes/kubelet.env`
