Backup the project:

```
oc get -o yaml --export all > openshift-play.<DATE>.yaml
```

Clear the project:  

```
oc delete all --all

pod "auditquery-3-6d6tc" deleted
pod "indy-1-4hdkr" deleted
pod "jgroups-gossip-1-cmww7" deleted
pod "jgroups-gossip-1-hrj4t" deleted
replicationcontroller "auditquery-1" deleted
replicationcontroller "auditquery-2" deleted
replicationcontroller "auditquery-3" deleted
replicationcontroller "indy-1" deleted
replicationcontroller "jgroups-gossip-1" deleted
service "auditquery" deleted
service "indy" deleted
service "jgroups-gossip" deleted
deploymentconfig.apps.openshift.io "auditquery" deleted
deploymentconfig.apps.openshift.io "indy" deleted
deploymentconfig.apps.openshift.io "jgroups-gossip" deleted
imagestream.image.openshift.io "auditquery" deleted
imagestream.image.openshift.io "base-jdk" deleted
imagestream.image.openshift.io "indy" deleted
imagestream.image.openshift.io "jgroups-gossip" deleted
route.route.openshift.io "auditquery" deleted
route.route.openshift.io "indy" deleted
route.route.openshift.io "jgroups-gossip" deleted
```

Re-create it from existing templates:

```
oc create -f openshift.io/projects/noc_local/openshift-play.0425.yaml
```

