1. generate the configmap from the existing configs
````
oc login
oc project nos-perf
oc create configmap auditquery-config --from-file cache/src/main/resources/
````
