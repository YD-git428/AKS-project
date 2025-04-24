bootstrap:
	terraform plan 
	terraform apply -auto-approve
	terraform refresh >/dev/null
	terraform output >../aks/terraform.tfvars
	cd ../aks	&&	terraform init 

teardown:
	cd ../aks && rm -rf .terraform 
	terraform destroy -auto-approve

