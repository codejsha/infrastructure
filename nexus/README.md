# Nexus

## Install

```bash
### helm chart
bash ./helm-install-nexus.sh
### docker container
bash ./docker-run-nexus.sh
```

## Configuration

```bash
bash ./all.sh
```

### Repository

- [get-repository-list.sh](/nexus/get-repository-list.sh)
- [delete-repository.sh](/nexus/delete-repository.sh)

### Blobstore

- [create-blobstore.sh](/nexus/create-blobstore.sh)
- [get-blobstore-list.sh](/nexus/get-blobstore-list.sh)
- [get-blobstore.sh](/nexus/get-blobstore.sh)
- [delete-blobstore.sh](/nexus/delete-blobstore.sh)

### Docker

- [create-docker-group-repo.sh](/nexus/create-docker-group-repo.sh)
- [create-docker-hosted-repo.sh](/nexus/create-docker-hosted-repo.sh)
- [create-docker-proxy-repo.sh](/nexus/create-docker-proxy-repo.sh)
- [update-docker-group-repo.sh](/nexus/update-docker-group-repo.sh)

### Helm

- [create-helm-hosted-repo.sh](/nexus/create-helm-hosted-repo.sh)
- [create-helm-proxy-repo.sh](/nexus/create-helm-proxy-repo.sh)

### Maven

- [create-maven-group-repo.sh](/nexus/create-maven-group-repo.sh)
- [create-maven-hosted-repo.sh](/nexus/create-maven-hosted-repo.sh)
- [create-maven-proxy-repo.sh](/nexus/create-maven-proxy-repo.sh)
- [update-maven-group-repo.sh](/nexus/update-maven-group-repo.sh)


### Management

user:

- [create-user.sh](/nexus/create-user.sh)
- [get-user-list.sh](/nexus/get-user-list.sh)

realms:

- [get-active-realms-list.sh](/nexus/get-active-realms-list.sh)
- [get-available-realms-list.sh](/nexus/get-available-realms-list.sh)
- [set-active-realms-list.sh](/nexus/set-active-realms-list.sh)

health check:

- [health-check.sh](/nexus/health-check.sh)
