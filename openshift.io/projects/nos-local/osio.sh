#!/bin/bash

while getopts 'cbrd:' c
do
  case $c in
    c) ACTION=CLEAR  ;;
    b) ACTION=BACKUP ;;
    r) ACTION=RESTORE ;;
    d) TEMPLATES_DIR=$OPTARG ;;
  esac
done

echo "ACTION: $ACTION"

exposeSvc()
{
  for app in jgroups-gossip auditquery indy
  do
    echo "oc expose svc/$app"
    oc expose svc/$app
  done
}

backup()
{
  if [ -n "$TEMPLATES_DIR" ]; then
    echo "oc get -o yaml --export $1 > $TEMPLATES_DIR/$1.yaml"
    oc get -o yaml --export $1 > $TEMPLATES_DIR/$1.yaml
  else
    echo "oc get -o yaml --export $1 > $1.yaml"
    oc get -o yaml --export $1 > $1.yaml
  fi
}

restore()
{
  if [ -n "$TEMPLATES_DIR" ]; then
    echo "oc create -f $TEMPLATES_DIR/$1.yaml"
    oc create -f $TEMPLATES_DIR/$1.yaml
  else
    echo "oc create -f $1.yaml"
    oc create -f $1.yaml
  fi
}

case $ACTION in
  BACKUP) 
    for object in imagestreams dc svc
    do
      backup $object
    done
  ;;
  RESTORE)
    for object in imagestreams dc svc
    do
      restore $object
    done
    exposeSvc
  ;;
  CLEAR)
    echo "oc delete all --all"
    oc delete all --all
  ;;
esac

