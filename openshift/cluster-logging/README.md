# Cluster Logging

- https://docs.openshift.com/container-platform/4.6/logging/cluster-logging-deploying.html
- https://github.com/openshift/cluster-logging-operator

## API Resources

```txt
NAME               SHORTNAMES    APIGROUP                NAMESPACED    KIND
clusterloggings                  logging.openshift.io    true          ClusterLogging
collectors                       logging.openshift.io    true          Collector
elasticsearches                  logging.openshift.io    true          Elasticsearch
kibanas                          logging.openshift.io    true          Kibana
logforwardings                   logging.openshift.io    true          LogForwarding
```

## Operator Lifecycle Manager (OLM)

```txt
NAME                                                         AGE
operatorgroup.operators.coreos.com/openshift-logging-wmdxq   45h

NAME                                             CSV                                    APPROVAL    APPROVED
installplan.operators.coreos.com/install-ms486   clusterlogging.4.5.0-202102032236.p0   Automatic   true
installplan.operators.coreos.com/install-vf5wl   clusterlogging.4.5.0-202102032236.p0   Automatic   true

NAME                                                                                      DISPLAY                  VERSION                 REPLACES   PHASE
clusterserviceversion.operators.coreos.com/clusterlogging.4.5.0-202102032236.p0           Cluster Logging          4.5.0-202102032236.p0              Succeeded
clusterserviceversion.operators.coreos.com/elasticsearch-operator.4.5.0-202102041049.p0   Elasticsearch Operator   4.5.0-202102041049.p0              Succeeded

NAME                                                PACKAGE           SOURCE             CHANNEL
subscription.operators.coreos.com/cluster-logging   cluster-logging   redhat-operators   4.5
```
