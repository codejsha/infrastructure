#!/usr/bin/bash

PASSWORD="changeit"

NAMESPACE="jenkins-system"
kubectl create namespace ${NAMESPACE}

# helm install my-jenkins \
helm upgrade --install my-jenkins \
    --namespace ${NAMESPACE} \
    --set master.adminUser="admin" \
    --set master.adminPassword="${PASSWORD}" \
    --set master.ingress.enabled="true" \
    --set master.ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set master.ingress.hostName="jenkins.example.com" \
    --set master.ingress.path="/" \
    --set agent.resources.requests.cpu="128m" \
    --set agent.resources.requests.memory="512Mi" \
    --set agent.resources.limits.cpu="256m" \
    --set agent.resources.limits.memory="512Mi" \
    --set persistence.enabled="true" \
    --set persistence.storageClass="rook-ceph-block" \
    --version 2.4.1 \
    stable/jenkins

    ### agent
    # --set agent.tag="4.3-7-jdk11" \
    # --set agent.tag="4.3-7" \

    ### prefix
    # --set master.jenkinsUriPrefix="/jenkins" \

    ### for loadbalancer
    # --set master.serviceType="LoadBalancer" \
    # --set master.loadBalancerIP="10.10.10.50" \
