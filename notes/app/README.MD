````
oc login https://api.starter-us-east-1.openshift.com --token=<>

You have one project on this server: "nos-local"

Using project "nos-local".
````

#### Deploy the GossipRouter on OSE

````
$> oc new-app jboss/jgroups-gossip
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

