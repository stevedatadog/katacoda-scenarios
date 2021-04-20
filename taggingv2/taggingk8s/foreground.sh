#!/bin/bash

while [ ! -f /root/taggingk8s/lotsofpods.yaml ]; do sleep 1; done
while [ ! -f /root/taggingk8s/datadog.yaml ]; do sleep 1; done
clear

kubeloopstart=`date +%s`
until kubectl create secret generic datadog-api --from-literal=token=$DD_API_KEY
do
  kubeloopend=`date +%s`
  kubeloopruntime=$((kubeloopend-kubeloopstart))
  echo "kubectl isn't ready yet."
  echo "It has been $kubeloopruntime seconds"
  echo "If this doesn't resolve after 60 seconds, contact support."
  sleep 2
done

kubectl apply -f taggingk8s/lotsofpods.yaml
kubectl apply -f taggingk8s/datadog.yaml

statusupdate complete

prepenvironment