# Docker

## Install

```bash
# Docker
bash ./install-docker.sh
# Docker Compose
bash ./install-docker-compose.sh
```

### Docker Registry

```bash
bash ./helm-install-docker-registry.sh
```

## Configuration file

`${HOME}/.docker/config.json`: [config.json](/docker/config.json)

## Daemon

- https://docs.docker.com/engine/reference/commandline/dockerd/
- https://docs.docker.com/registry/insecure/

`/etc/docker/daemon.json`: [daemon.json](/docker/daemon.json)

## Expose Docker daemon socket

### Configure Service

[docker-service.sh](/docker/docker-service.sh)

```bash
bash ./docker-service.sh
```

The `docker-service.sh` script create `/etc/systemd/system/docker.service.d/override.conf` file:

```conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd --host unix:///var/run/docker.sock --host tcp://0.0.0.0:2375
```

### Restart Docker daemon

```bash
systemctl daemon-reload
systemctl restart docker.service
```

## Other commands

- `base64-encoded.sh`
- `docker-commands.sh`
- `docker-mount-option.sh`

## Portainer

https://www.portainer.io/installation/

Requirements: Docker daemon socket

### Set environment

```bash
bash ./docker-run-portainer.sh
```

Select Docker environment, and then set Name and Endpoint URL.

![portainer-endpoint](/contents/images/portainer-add-endpoint.jpg)
