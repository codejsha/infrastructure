# Installing Kubernetes with Kubespray

- https://kubespray.io/
- https://github.com/kubernetes-sigs/kubespray
- https://kubernetes.io/docs/setup/production-environment/tools/kubespray/

## Virtual machine

### Create Hyper-V VMs

[create-kube-vm.ps1](/kubernetes/kubespray/create-kube-vm.ps1)

```powershell
create-kube-vm.ps1
```

### Install OS

manually install linux (CentOS)

### Requirements

[require-all-node.sh](/kubernetes/kubespray/require-all-node.sh)

```bash
bash ./require-all-node.sh
```

### Add scripts

- [set-hostname.sh](/kubernetes/kubespray/set-hostname.sh)
- [set-network.sh](/kubernetes/kubespray/set-network.sh)

### Copy vhd

[convert-kube-vhd.ps1](/kubernetes/kubespray/convert-kube-vhd.ps1)

```powershell
convert-kube-vhd.ps1
```

## Pre-install

### Hostname and network

[set-hostname.sh](/kubernetes/kubespray/set-hostname.sh)

```bash
# controlplane1
bash ./set-hostname.sh c1
# controlplane2
bash ./set-hostname.sh c2
# controlplane3
bash ./set-hostname.sh c3
# node1
bash ./set-hostname.sh n1
# node2
bash ./set-hostname.sh n2
# node3
bash ./set-hostname.sh n3
```

[set-network.sh](/kubernetes/kubespray/set-network.sh)

```bash
# all hosts
bash ./set-network.sh
```

### Copy ssh keys

- [pre-copy-ssh-key.sh](/kubernetes/kubespray/pre-copy-ssh-key.sh)
- [copy-ssh-key.sh](/kubernetes/kubespray/copy-ssh-key.sh)

```bash
bash ./pre-copy-ssh-key.sh
export PASSWORD="<PASSWORD>"
bash ./copy-ssh-key.sh
```

## Deploy cluster

### Configure

- [all.yaml](/kubernetes/kubespray/all.yaml)
- [docker.yaml](/kubernetes/kubespray/docker.yaml)
- [addons.yaml](/kubernetes/kubespray/addons.yaml)
- [k8s-cluster.yaml](/kubernetes/kubespray/k8s-cluster.yaml)

### Run playbook

[install-k8s-kubespray.sh](/kubernetes/kubespray/install-k8s-kubespray.sh)

```bash
export PASSWORD="<PASSWORD>"
bash ./install-k8s-kubespray.sh
```

## Post-install

### Copy config and cert files

[post-install.sh](/kubernetes/kubespray/post-install.sh)

```bash
bash ./post-install.sh
```

### Dashboard

- [dashboard-clusterrolebinding.sh](/kubernetes/kubespray/dashboard-clusterrolebinding.sh)
- [dashboard-ingress.yaml](/kubernetes/kubespray/dashboard-ingress.yaml)

```bash
bash ./dashboard-clusterrolebinding.sh
kubectl apply -filename dashboard-ingress.yaml
```

### Netchecker

[netchecker-ingress.yaml](/kubernetes/kubespray/netchecker-ingress.yaml)

```bash
kubectl apply -filename netchecker-ingress.yaml
```
