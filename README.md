# openshift-play

Try to install the auditquery and jgroups-gossip on the openshif.io.

#### openshift.io instance

```
oc login https://api.starter-us-east-1.openshift.com --token=<>

You have one project on this server: "nos-local"

Using project "nos-local".
```

#### Deploy the GossipRouter on OSE

````
$> oc new-app jboss/jgroups-gossip -e LogLevel=trace
--> Found Docker image 8c23d5c (2 months old) from Docker Hub for "jboss/jgroups-gossip"

    * An image stream tag will be created as "jgroups-gossip:latest" that will track this image
    * This image will be deployed in deployment config "jgroups-gossip"
    * Port 12001/tcp will be load balanced by service "jgroups-gossip"
      * Other containers can access this service through the hostname "jgroups-gossip"

--> Creating resources ...
    imagestream.image.openshift.io "jgroups-gossip" created
    deploymentconfig.apps.openshift.io "jgroups-gossip" created
    service "jgroups-gossip" created
--> Success
    Application is not exposed. You can expose services to the outside world by executing one or more of the commands below:
     'oc expose svc/jgroups-gossip'
    Run 'oc status' to view your app.
````

#### Deploy the auditquery on OSE

[AuditQuery test images](https://cloud.docker.com/repository/docker/jind0001/auditquery)  

````
$> oc new-app jind0001/auditquery:1.0
--> Found Docker image a4d775b (2 hours old) from Docker Hub for "jind0001/auditquery:1.0"

    * An image stream tag will be created as "auditquery:1.0" that will track this image
    * This image will be deployed in deployment config "auditquery"
    * Port 8082/tcp will be load balanced by service "auditquery"
      * Other containers can access this service through the hostname "auditquery"

--> Creating resources ...
    imagestream.image.openshift.io "auditquery" created
    deploymentconfig.apps.openshift.io "auditquery" created
    service "auditquery" created
--> Success
    Application is not exposed. You can expose services to the outside world by executing one or more of the commands below:
     'oc expose svc/auditquery'
    Run 'oc status' to view your app.oc new-app jind0001/auditquery:1.0
````

#### Create ConfigMaps from the existing config files
````
oc create configmap auditquery-config --from-file auditquery/docker/conf/

````

#### Add ConfigMap for auditquery

Add Config Files in Applications/Deployments/auditquery
- select config map source 
- fill the mount path (target path for the config files)

Then we can ref the config files from the mounted path.   

#### Deploy the indy on OSE

[Indy test images](https://cloud.docker.com/repository/docker/jind0001/indy)  
````
oc new-app jind0001/indy:1.4
--> Found Docker image 7132f25 (2 minutes old) from Docker Hub for "jind0001/indy:1.4"

    * An image stream tag will be created as "indy:1.4" that will track this image
    * This image will be deployed in deployment config "indy"
    * Port 8080/tcp will be load balanced by service "indy"
      * Other containers can access this service through the hostname "indy"
    * WARNING: Image "jind0001/indy:1.4" runs as the 'root' user which may not be permitted by your cluster administrator

--> Creating resources ...
    imagestreamtag.image.openshift.io "indy:1.4" created
    deploymentconfig.apps.openshift.io "indy" created
    service "indy" created
--> Success
    Application is not exposed. You can expose services to the outside world by executing one or more of the commands below:
     'oc expose svc/indy'
    Run 'oc status' to view your app.
````

#### JGroups tcp config
````
....
<TCPGOSSIP initial_hosts="${jgroups.gossip_router_hosts:HostA[12001]}" />
....
````
[jgroups gossip config](https://access.redhat.com/solutions/57974)
