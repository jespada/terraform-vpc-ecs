.PHONY: all plan apply destroy

all: plan apply

plan:
	terraform plan -var-file terraform.tfvars -input=true

apply:
	terraform apply

destroy:
	terraform destroy
remote:
	terraform remote config -backend=s3 -backend-config="bucket=terraform-app-states" -backend-config="key=terraform.tfstate.base" -backend-config="region=eu-west-1"
