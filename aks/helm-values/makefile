externaldns:
    
	az aks get-credentials --resource-group coderco-azureproj --name aks-cluster
	helm install external-dns external-dns/external-dns --namespace external-dns --create-namespace -f externaldns.yml
	kubectl create secret generic external-dns-secret --from-file=azure.json=./secret/azure.json -n external-dns
	helm upgrade external-dns external-dns/external-dns -n external-dns --set env[0].name=AZURE_CONFIG_FILE --set env[0].value=/etc/kubernetes/azure.json

	


