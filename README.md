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
oc create configmap auditquery-config --from-file app/auditquery/docker/conf/

oc create configmap auditquery-logging-config --from-file app/auditquery/docker/conf/logging/

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
<config xmlns="urn:org:jgroups"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="urn:org:jgroups http://www.jgroups.org/schema/jgroups-4.0.xsd">

....
<TCPGOSSIP initial_hosts="${jgroups.gossip_router_hosts:HostA[12001]}" />
....

</config>
````
[jgroups gossip config](https://access.redhat.com/solutions/57974)

#### Issues:

##### 1: IPv6
```
Use of IPv6. JGroups does work with IPv6, but some JDK implementations still have issues with it, so you can turn IPv6 off by passing the "-Djava.net.preferIPv4Stack=true" system property to the JVM. You can force use of IPv6 addresses by using setting system property -Djava.net.preferIPv6Addresses=true. If you use IPv6 addresses, you should also define IPv6 addresses in your configuration; e.g. if you set bind_addr="192.168.1.5" in UDP, JGroups will try to pick IPv4 addresses if an IPv4 stack is available, or you're running a dual stack. 
```
