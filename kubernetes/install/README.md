# Installing Kubernetes with Kubespray

- https://kubespray.io/
- https://github.com/kubernetes-sigs/kubespray
- https://kubernetes.io/docs/setup/production-environment/tools/kubespray/

## Virtual machine

### create hyper-v vm

```powershell
create-kube-vm.ps1
```

### install os

manually install linux(cent os)

### requirements

```bash
bash require-all-node.sh
```

### add scripts

- set-hostname.sh
- set-network.sh
- hosts.txt

### copy vhd

```powershell
convert-kube-vhd.ps1
```

## Pre-install

### configure

- hostname: `set-hostname.sh`
- network: `set-network.sh`

### copy ssh keys

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

### configure

- `all.yaml`
- `docker.yaml`
- `addons.yaml`
- `k8s-cluster.yaml`

### run playbook

```bash
bash install-k8s-kubespray.sh
```

## Post-install

### copy config and cert files

```bash
bash post-install.sh
```

### dashboard

```bash
bash dashboard-clusterrolebinding.sh
kubectl apply -f dashboard-ingress.yaml
```
