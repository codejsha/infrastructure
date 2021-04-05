#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

### USER
cd security

### create-user.sh ${USER_ID} ${USER_PASSWORD}
bash ./create-user.sh "developer" "developer"

cd ..

######################################################################

### BLOBSTORE
cd blobstore

export AWS_ACCESS_KEY="${AWS_ACCESS_KEY}"
export AWS_SECRET_KEY="${AWS_SECRET_KEY}"

### create-blobstore.sh ${BLOBSTORE_NAME}
bash ./create-blobstore.sh "nexus-maven-central"
bash ./create-blobstore.sh "nexus-docker-hub"
# bash ./create-blobstore.sh "nexus-docker-registry"
# bash ./create-blobstore.sh "nexus-docker-kube-registry"
bash ./create-blobstore.sh "nexus-docker-harbor"
# bash ./create-blobstore.sh "nexus-helm-chartmuseum"
bash ./create-blobstore.sh "nexus-helm-harbor"

cd ..

######################################################################

### MAVEN
cd maven

### delete-repository.sh ${REPOSITORY_NAME}
bash ./delete-repository.sh "maven-central"

### create-maven-proxy-repo.sh ${REPOSITORY_NAME} ${BLOBSTORE_NAME} ${REMOTE_URL}
bash ./create-maven-proxy-repo.sh "maven-central" "nexus-maven-central" "https://repo1.maven.org/maven2/"

### update-maven-group-repo.sh ${REPOSITORY_NAME} ${BLOBSTORE_NAME} ${REPOSITORY_MEMBER_NAMES}
bash ./update-maven-group-repo.sh "maven-public" "default" "maven-central\", \"maven-releases\", \"maven-snapshots"

cd ..

######################################################################

### DOCKER
cd docker

### create-docker-proxy-repo.sh ${REPOSITORY_NAME} ${BLOBSTORE_NAME} ${REMOTE_URL} ${DOCKER_INDEX_TYPE}
bash ./create-docker-proxy-repo.sh "docker-hub" "nexus-docker-hub" "https://registry-1.docker.io" "HUB"
# bash ./create-docker-proxy-repo.sh "docker-registry" "nexus-docker-registry" "http://my-docker-registry.registry-system:5000" "REGISTRY"
# bash ./create-docker-proxy-repo.sh "docker-registry" "nexus-docker-registry" "http://registry.example.com" "REGISTRY"
# bash ./create-docker-proxy-repo.sh "docker-kube-registry" "nexus-docker-kube-registry" "http://registry.kube-system:5000" "REGISTRY"
bash ./create-docker-proxy-repo.sh "docker-harbor" "nexus-docker-harbor" "https://core.harbor.example.com" "REGISTRY"
# bash ./create-docker-proxy-repo.sh "docker-harbor" "nexus-docker-harbor" "https://my-harbor-harbor-registry.harbor-system:5000" "REGISTRY"

### create-docker-group-repo.sh ${REPOSITORY_NAME} ${BLOBSTORE_NAME} ${REPOSITORY_MEMBER_NAMES}
# bash ./create-docker-group-repo.sh "docker-group" "default" "docker-hub\", \"docker-registry"
# bash ./create-docker-group-repo.sh "docker-group" "default" "docker-hub\", \"docker-kube-registry"
bash ./create-docker-group-repo.sh "docker-group" "default" "docker-hub\", \"docker-harbor"

### update-docker-group-repo.sh ${REPOSITORY_NAME} ${BLOBSTORE_NAME} ${REPOSITORY_MEMBER_NAMES}
# bash ./update-docker-group-repo.sh "docker-group" "default" "docker-hub\", \"docker-registry\", \"docker-kube-registry"
# bash ./update-docker-group-repo.sh "docker-group" "default" "docker-hub\", \"docker-harbor"

### set-active-realms-list.sh ${REALM_IDS}
bash ./set-active-realms-list.sh "\"NexusAuthenticatingRealm\", \"NexusAuthorizingRealm\", \"DockerToken\""

cd ..

######################################################################

### HELM
cd helm

### create-helm-proxy-repo.sh ${REPOSITORY_NAME} ${BLOBSTORE_NAME} ${REMOTE_URL}
# bash ./create-helm-proxy-repo.sh "helm-chartmuseum" "nexus-helm-chartmuseum" "http://chartmuseum-service.chart-system:8080"
bash ./create-helm-proxy-repo.sh "helm-harbor" "nexus-helm-harbor" "https://core.harbor.example.com"

cd ..

######################################################################

### DELETE

# bash ./delete-repository.sh "maven-central"
# bash ./delete-repository.sh "docker-hub"
# bash ./delete-repository.sh "docker-registry"
# bash ./delete-repository.sh "docker-harbor"
# bash ./delete-repository.sh "docker-group"
# bash ./delete-repository.sh "helm-chartmuseum"
# bash ./delete-repository.sh "helm-harbor"

# bash ./delete-blobstore.sh "nexus-maven-central"
# bash ./delete-blobstore.sh "nexus-docker-hub"
# bash ./delete-blobstore.sh "nexus-docker-registry"
# bash ./delete-blobstore.sh "nexus-docker-kube-registry"
# bash ./delete-blobstore.sh "nexus-docker-harbor"
# bash ./delete-blobstore.sh "nexus-helm-chartmuseum"
# bash ./delete-blobstore.sh "nexus-helm-harbor"
