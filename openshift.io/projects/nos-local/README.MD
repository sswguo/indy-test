Backup the project:

```
mkdir backup
./osio.sh -b -d backup
```

Clear the resource:  

```
./osio.sh -c
```

Restore the project:

- Init the configMaps
```
oc delete configmap auditquery-config
oc create configmap auditquery-config --from-file configmap/
```

- Restore the other resources
```
./osio.sh -r -d backup
```

Init the apps from beginning 

_(init the apps based on the templates in dir templates/)_

```
./osio.sh -n
```

