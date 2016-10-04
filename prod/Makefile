.PHONY: all plan norefresh apply destroy remote

all: plan apply

plan:
	terraform plan -var 'env=prod' -var-file terraform.tfvars -parallelism=100

norefresh:
	terraform plan -var 'env=prod' -var-file terraform.tfvars

apply:
	terraform apply -var 'env=prod' -var-file terraform.tfvars

apply-norefresh:
	terraform apply -var 'env=prod' -var-file terraform.tfvars -refresh=false

destroy:
	terraform destroy -var 'env=prod'
remote:
	terraform remote config -backend=s3 -backend-config="bucket=terraform-app-states" -backend-config="key=terraform.tfstate.prod" -backend-config="region=eu-west-1"
