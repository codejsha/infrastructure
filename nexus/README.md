# Nexus

## Install

### Docker

```bash
bash ./docker-run-nexus.sh
```

### Kubernetes

```bash
bash ./helm-install-nexus.sh
```

## Configuration

```bash
bash ./all.sh
```

### Repository

- `get-repository-list.sh`
- `delete-repository.sh`

### Blobstore

- `create-blobstore.sh`
- `get-blobstore-list.sh`
- `get-blobstore.sh`
- `delete-blobstore.sh`

### Docker

- `create-docker-group-repo.sh`
- `create-docker-hosted-repo.sh`
- `create-docker-proxy-repo.sh`
- `update-docker-group-repo.sh`

### Helm

- `create-helm-hosted-repo.sh`
- `create-helm-proxy-repo.sh`

### Maven

- `create-maven-group-repo.sh`
- `create-maven-hosted-repo.sh`
- `create-maven-proxy-repo.sh`
- `update-maven-group-repo.sh`

### Security

user:

- `create-user.sh`
- `get-user-list.sh`

realms:

- `get-active-realms-list.sh`
- `get-available-realms-list.sh`
- `set-active-realms-list.sh`
