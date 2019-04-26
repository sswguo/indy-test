Backup and restore the project, ref the backup.sh. 

```
oc get -o yaml --export all > openshift-play.<DATE>.yaml
```

Clear the project:  

```
oc delete all --all
```

Re-create it from existing templates:

```
oc create -f openshift.io/projects/noc_local/openshift-play.0425.yaml
```
