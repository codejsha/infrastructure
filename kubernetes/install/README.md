# Installing Kubernetes with Kubespray

- https://kubespray.io/
- https://github.com/kubernetes-sigs/kubespray
- https://kubernetes.io/docs/setup/production-environment/tools/kubespray/

## Virtual machine

### Create Hyper-V VMs

[create-kube-vm.ps1](/kubernetes/install/create-kube-vm.ps1)

```powershell
create-kube-vm.ps1
```

### Install OS

manually install linux (CentOS)

### Requirements

[require-all-node.sh](/kubernetes/install/require-all-node.sh)

```bash
bash ./require-all-node.sh
```

### Add scripts

- [set-hostname.sh](/kubernetes/install/set-hostname.sh)
- [set-network.sh](/kubernetes/install/set-network.sh)

### Copy vhd

[convert-kube-vhd.ps1](/kubernetes/install/convert-kube-vhd.ps1)

```powershell
convert-kube-vhd.ps1
```

## Pre-install

### Hostname and network

[set-hostname.sh](/kubernetes/install/set-hostname.sh)

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

[set-network.sh](/kubernetes/install/set-network.sh)

```bash
# all hosts
bash ./set-network.sh
```

### Copy ssh keys

- [pre-copy-ssh-key.sh](/kubernetes/install/pre-copy-ssh-key.sh)
- [copy-ssh-key.sh](/kubernetes/install/copy-ssh-key.sh)

```bash
bash ./pre-copy-ssh-key.sh
export PASSWORD="<PASSWORD>"
bash ./copy-ssh-key.sh
```

## Deploy cluster

### Configure

- [all.yaml](/kubernetes/install/all.yaml)
- [docker.yaml](/kubernetes/install/docker.yaml)
- [addons.yaml](/kubernetes/install/addons.yaml)
- [k8s-cluster.yaml](/kubernetes/install/k8s-cluster.yaml)

### Run playbook

[install-k8s-kubespray.sh](/kubernetes/install/install-k8s-kubespray.sh)

```bash
export PASSWORD="<PASSWORD>"
bash ./install-k8s-kubespray.sh
```

## Post-install

### Copy config and cert files

[post-install.sh](/kubernetes/install/post-install.sh)

```bash
bash ./post-install.sh
```

### Dashboard

- [dashboard-clusterrolebinding.sh](/kubernetes/install/dashboard-clusterrolebinding.sh)
- [dashboard-ingress.yaml](/kubernetes/install/dashboard-ingress.yaml)

```bash
bash ./dashboard-clusterrolebinding.sh
kubectl apply -filename dashboard-ingress.yaml
```

### Netchecker

[netchecker-ingress.yaml](/kubernetes/install/netchecker-ingress.yaml)

```bash
kubectl apply -filename netchecker-ingress.yaml
```
