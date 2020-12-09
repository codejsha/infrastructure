# Kubernetes

## Install

[Installing Kubernetes with Kubespray README](/kubernetes/kubespray/README.md)

## kubectl

https://kubernetes.io/docs/tasks/tools/install-kubectl

```bash
bash ./install-kubectl.sh
```

## kubectl-aliases

https://github.com/ahmetb/kubectl-aliases

```bash
bash ./install-kubectl-aliases.sh
```

## Krew

https://krew.sigs.k8s.io/

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
