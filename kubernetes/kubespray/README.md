# Installing Kubernetes with Kubespray

- https://kubespray.io/
- https://github.com/kubernetes-sigs/kubespray
- https://kubernetes.io/docs/setup/production-environment/tools/kubespray/

Table of Contents:

- [Pre-install](#pre-install)
- [Virtual machine configuration](#virtual-machine-configuration)
- [Host configuration](#host-configuration)
- [Deploy cluster](#deploy-cluster)
- [Post-install](#post-install)

## Pre-install

```powershell
### powershell
.\helper.ps1
```

## Virtual machine configuration

### 1. Create Hyper-V VMs

```powershell
### powershell
.\create-kube-vm.ps1
```

### 2. Install OS

manually install linux (CentOS)

update packages:

```bash
sudo dnf update -y
sudo yum update -y
```

### 3. Kubernetes requirements

```bash
bash ./pre-install.sh
```

### 4. Add scripts

- `set-hostname.sh`
- `set-network.sh` or `set-network-dual.sh`

### 5. Copy vhd

```powershell
### powershell
.\convert-kube-vhd.ps1
```

## Host configuration

### 1. Set hostname

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

### 2. Set network

```bash
# one network
bash ./set-network.sh

# two networks
bash ./set-network-dual.sh
```

### 3. Copy ssh keys

```bash
bash ./pre-copy-ssh-key.sh
export PASSWORD="${PASSWORD}"
bash ./copy-ssh-key.sh
```

## Deploy cluster

### 1. Configure cluster settings

- `all.yaml`
- `docker.yaml`
- `addons.yaml`
- `k8s-cluster.yaml`
- `k8s-net-calico.yml`

### 2. Run playbook

```bash
export PASSWORD="${PASSWORD}"
bash ./install-k8s-kubespray.sh
```

## Post-install

### 1. Copy config and cert files

```bash
bash ./post-install.sh
```

### 2. Create dashboard ingress

```bash
bash ./dashboard-clusterrolebinding.sh
kubectl apply --filename dashboard-ingress.yaml
```
