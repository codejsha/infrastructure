#!/usr/bin/bash

NAMESPACE="kafka-system"
kubectl create namespace ${NAMESPACE}

# helm install my-kafka-manager \
helm upgrade --install my-kafka-manager \
    --namespace ${NAMESPACE} \
    --set zkHosts="my-kafka-zookeeper-headless:2181" \
    --set clusters[0].name="mycluster" \
    --set clusters[0].zkHosts="my-kafka-zookeeper-headless:2181" \
    --set clusters[0].kafkaVersion= \
    --set clusters[0].jmxEnabled= \
    --set clusters[0].jmxUser= \
    --set clusters[0].jmxPass= \
    --set clusters[0].jmxSsl= \
    --set clusters[0].logkafkaEnabled= \
    --set clusters[0].pollConsumers= \
    --set clusters[0].filterConsumers= \
    --set clusters[0].activeOffsetCacheEnabled= \
    --set clusters[0].displaySizeEnabled= \
    --set clusters[0].securityProtocol= \
    --set clusters[0].tuning.brokerViewUpdatePeriodSeconds= \
    --set clusters[0].tuning.clusterManagerThreadPoolSize= \
    --set clusters[0].tuning.clusterManagerThreadPoolQueueSize= \
    --set clusters[0].tuning.kafkaCommandThreadPoolSize= \
    --set clusters[0].tuning.kafkaCommandThreadPoolQueueSize= \
    --set clusters[0].tuning.logkafkaCommandThreadPoolSize= \
    --set clusters[0].tuning.logkafkaCommandThreadPoolQueueSize= \
    --set clusters[0].tuning.logkafkaUpdatePeriodSeconds= \
    --set clusters[0].tuning.partitionOffsetCacheTimeoutSecs= \
    --set clusters[0].tuning.brokerViewThreadPoolSize= \
    --set clusters[0].tuning.brokerViewThreadPoolQueueSize= \
    --set clusters[0].tuning.offsetCacheThreadPoolSize= \
    --set clusters[0].tuning.offsetCacheThreadPoolQueueSize= \
    --set clusters[0].tuning.kafkaAdminClientThreadPoolSize= \
    --set clusters[0].tuning.kafkaAdminClientThreadPoolQueueSize= \
    --set clusters[0].tuning.kafkaManagedOffsetMetadataCheckMillis= \
    --set clusters[0].tuning.kafkaManagedOffsetGroupCacheSize= \
    --set clusters[0].tuning.kafkaManagedOffsetGroupExpireDays= \
    --set ingress.enabled="true" \
    --set ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set ingress.hosts={"kafka.example.com"} \
    --version 2.3.1 \
    stable/kafka-manager

    ### prefix for loadbalancer or ingress
    # --set livenessProbe.httpGet.path="/kafka-manager/api/health" \
    # --set readinessProbe.httpGet.path="/kafka-manager/api/health" \
    # --set javaOptions="-Dplay.http.context=/kafka-manager" \
    # --set ingress.path="/kafka-manager" \

    ### for loadbalancer
    # --set service.type="LoadBalancer" \
