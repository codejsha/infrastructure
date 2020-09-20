# Installing Kubernetes with Kubespray

- https://kubespray.io/
- https://github.com/kubernetes-sigs/kubespray
- https://kubernetes.io/docs/setup/production-environment/tools/kubespray/

## Virtual machine

```powershell
### create hyper-v vm
create-kube-vm.ps1

### install linux
# manually install linux(cent os)
```

```bash
### in linux
bash require-all-node.sh

### add hosts
cat <<EOF | sudo tee -a /etc/hosts
$(cat hosts.txt)
EOF
```

```powershell
convert-kube-vhd.ps1
```

## Pre-install

### configure

- hostname: `set-hostname.sh`
- network: `set-network.sh`

### ssh key

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

```bash
bash post-install.sh
```

### dashboard

```bash
bash dashboard-clusterrolebinding.sh
kubectl apply -f dashboard-ingress.yaml
```
