# Installing Kubernetes with Kubespray

- https://kubespray.io/
- https://github.com/kubernetes-sigs/kubespray
- https://kubernetes.io/docs/setup/production-environment/tools/kubespray/

## Virtual machine

### Create hyper-v vm

```powershell
create-kube-vm.ps1
```

### Install os

manually install linux(cent os)

### Requirements

```bash
bash require-all-node.sh
```

### Add scripts

- set-hostname.sh
- set-network.sh
- hosts.txt

### Copy vhd

```powershell
convert-kube-vhd.ps1
```

## Pre-install

### Configure

- hostname: `set-hostname.sh`
- network: `set-network.sh`

### Copy ssh keys

```bash
cat <<EOF | sudo tee -a /etc/hosts
$(cat hosts.txt)
EOF
```

```bash
bash pre-copy-ssh-key.sh
bash copy-ssh-key.sh
```

## Deploy cluster

### Configure

- `all.yaml`
- `docker.yaml`
- `addons.yaml`
- `k8s-cluster.yaml`

### Run playbook

```bash
bash install-k8s-kubespray.sh
```

## Post-install

### Copy config and cert files

```bash
bash post-install.sh
```

### Dashboard

```bash
bash dashboard-clusterrolebinding.sh
kubectl apply -f dashboard-ingress.yaml
```
