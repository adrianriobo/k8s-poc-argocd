#!/bin/bash

kind create cluster --name k8s-poc --config /opt/gitops/cluster/config.yaml

# Deploy temporary chartmuseum 
kind load docker-image $TEMPORARY_CHARTMUSEUM_IMAGE --name k8s-poc
kubectl apply -f $GITOPS_HOME/deployments/temporary-chartmuseum-all-in-one.yaml

# Alias temporary chartmuseum
node_ip=$(kubectl get nodes -o jsonpath={.items[0].status.addresses[?\(@.type==\"InternalIP\"\)].address})
echo "$node_ip charmuseum.k8s.poc" | tee -a /etc/hosts

# Add temporary repository required wait for temporary pod
while [[ $(kubectl get pods -l app=temporary-chartmuseum -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; 
do 
  echo "waiting for pod" && sleep 1; 
done
helm repo add temporary http://charmuseum.k8s.poc:30068/

# Install argo from 
helm install -f /opt/gitops/charts/argocd-values.yaml argocd temporary/argo-cd

mkdir -p logs
kind --name k8s-poc export logs logs
tail -f /logs/k8s-poc-control-plane/journal.log




