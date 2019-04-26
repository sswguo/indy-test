#!/bin/bash

for object in svc dc imagestreams
do
  echo "oc get -o yaml --export $object > $object.yaml"
  oc get -o yaml --export $object > $object.yaml
done

sleep 5

oc delete all --all

sleep 5

for object in imagestreams dc svc
do
  echo "oc create -f $object.yaml"
  oc create -f $object.yaml
done

sleep 1

for app in jgroups-gossip auditquery indy
do 
  echo "oc expose svc/$app"
  oc expose svc/$app
done
