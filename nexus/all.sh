#!/usr/bin/bash

bash create-user.sh "developer" "developer"

bash create-blobstore.sh "nexus-maven-central"
bash create-blobstore.sh "nexus-docker-hub"
bash create-blobstore.sh "nexus-docker-registry"
bash create-blobstore.sh "nexus-helm-chartmuseum"
# bash create-blobstore.sh "nexus-docker-kube-registry"

bash delete-repository.sh "maven-central"
bash create-maven-proxy-repo.sh "maven-central" "nexus-maven-central" "https://repo1.maven.org/maven2/"
bash update-maven-group-repo.sh "maven-public" "default" "\"maven-central\",\"maven-releases\",\"maven-snapshots\""

bash create-docker-proxy-repo.sh "docker-hub" "nexus-docker-hub" "https://registry-1.docker.io" "HUB"
bash create-docker-proxy-repo.sh "docker-registry" "nexus-docker-registry" "http://my-docker-registry.registry-system:5000" "REGISTRY"
# bash create-docker-proxy-repo.sh "docker-kube-registry" "nexus-docker-kube-registry" "http://registry.kube-system:5000" "REGISTRY"
bash create-docker-group-repo.sh "docker-group" "default" "\"docker-hub\",\"docker-registry\""
# bash create-docker-group-repo.sh "docker-group" "default" "\"docker-hub\",\"docker-kube-registry\""
# bash update-docker-group-repo.sh "docker-group" "default" "\"docker-hub\",\"docker-registry\",\"docker-kube-registry\""

bash create-helm-proxy-repo.sh "helm-chartmuseum" "nexus-helm-chartmuseum" "http://chartmuseum-service.chart-system:8080"

bash set-active-realms-list.sh "\"NexusAuthenticatingRealm\", \"NexusAuthorizingRealm\", \"DockerToken\""

### delete
# bash delete-repository.sh "maven-central"
# bash delete-repository.sh "docker-hub"
# bash delete-repository.sh "docker-registry"
# bash delete-repository.sh "docker-group"
# bash delete-repository.sh "helm-chartmuseum"
# bash delete-blobstore.sh "nexus-maven-central"
# bash delete-blobstore.sh "nexus-docker-hub"
# bash delete-blobstore.sh "nexus-docker-registry"
# bash delete-blobstore.sh "nexus-helm-chartmuseum"
