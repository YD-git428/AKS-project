#!/bin/bash
# Delete Helm releases
helm uninstall cert-manager --namespace cert-manager 
helm uninstall external-dns --namespace external-dns 
helm uninstall nginx-ingress-controller --namespace ingress-controller

#Delete Custom Resources
kubectl delete crd certificaterequests.cert-manager.io \
   certificates.cert-manager.io \
   challenges.acme.cert-manager.io \
   clusterissuers.cert-manager.io \
   issuers.cert-manager.io \
   orders.acme.cert-manager.io

#Delete namespaces
kubectl delete namespace cert-manager
kubectl delete secret external-dns-secret -n external-dns
