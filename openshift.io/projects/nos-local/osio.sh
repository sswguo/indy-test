#!/bin/bash

while getopts 'cbrnd:' c
do
  case $c in
    c) ACTION=CLEAR  ;;
    b) ACTION=BACKUP ;;
    r) ACTION=RESTORE ;;
    n) ACTION=NEW ;;
    d) TEMPLATES_DIR=$OPTARG ;;
  esac
done

echo "ACTION: $ACTION"

init()
{
  echo "oc create -f templates/$1.yaml"
  oc create -f templates/$1.yaml
}

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
  NEW)
    for object in imagestreams dc_auditquery svc_auditquery dc_jgroups svc_jgroups dc_indy svc_indy
    do
      init $object
    done
    exposeSvc
  ;;
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

