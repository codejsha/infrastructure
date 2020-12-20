# Docker

## Install

```bash
bash ./install-docker.sh
```

### Docker Registry

#### Container

- https://docs.docker.com/registry/deploying/

```bash
bash ./docker-run-docker-registry.sh
```

#### Helm chart

Deprecated chart

https://github.com/helm/charts#%EF%B8%8F-deprecation-and-archive-notice

```bash
bash ./helm-install-docker-registry.sh
```

### Docker compose

- https://github.com/docker/compose

```bash
bash ./install-docker-compose.sh
```

## Docker build

- https://docs.docker.com/engine/reference/commandline/build/

## Configuration file

`${HOME}/.docker/config.json`: [config.json](/docker/config.json)

## Daemon

- https://docs.docker.com/engine/reference/commandline/dockerd/
- https://docs.docker.com/registry/insecure/

`/etc/docker/daemon.json`: [daemon.json](/docker/daemon.json)

### Expose Docker daemon socket

#### Configure Service

[docker-service.sh](/docker/docker-service.sh)

```bash
bash ./docker-service.sh
```

The `docker-service.sh` script create `/etc/systemd/system/docker.service.d/override.conf` file:

```conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock --host tcp://0.0.0.0:2375
```

#### Restart Docker daemon

```bash
systemctl daemon-reload
systemctl restart docker.service
```

## Other commands

- `base64-encoded.sh`
- `docker-commands.sh`
- `docker-mount-option.sh`

## Dockerfile Examples

- [Kustomize README](/Kustomize/README.md)
- [FTP Server README](/linux/ftp-server/README.md)
- [RPM Package Repository Server README](/linux/rpm-package-repo-server/README.md)

## Portainer

- [Portainer README](/docker/portainer.md)
