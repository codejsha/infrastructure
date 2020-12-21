# Installing Kubernetes with Kubespray

- https://kubespray.io/
- https://github.com/kubernetes-sigs/kubespray
- https://kubernetes.io/docs/setup/production-environment/tools/kubespray/

## Virtual machine

### Create Hyper-V VMs

```powershell
create-kube-vm.ps1
```

### Install OS

manually install linux (CentOS)

### Requirements

```bash
bash ./require-all-node.sh
```

### Add scripts

- `set-hostname.sh`
- `set-network.sh`

### Copy vhd

```powershell
convert-kube-vhd.ps1
```

## Pre-install

### Hostname and network

set hostname:

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

set network:

```bash
# all hosts
bash ./set-network.sh
```

### Copy ssh keys

```bash
bash ./pre-copy-ssh-key.sh
export PASSWORD="${PASSWORD}"
bash ./copy-ssh-key.sh
```

## Deploy cluster

### Configure

- `all.yaml`
- `docker.yaml`
- `addons.yaml`
- `k8s-cluster.yaml`

### Run playbook

```bash
export PASSWORD="${PASSWORD}"
bash ./install-k8s-kubespray.sh
```

## Post-install

### Copy config and cert files

```bash
bash ./post-install.sh
```

### Dashboard

```bash
bash ./dashboard-clusterrolebinding.sh
kubectl apply -filename dashboard-ingress.yaml
```

### Netchecker

```bash
kubectl apply -filename netchecker-ingress.yaml
```
