# terraform building blocks for AWS vpc, route53, rds and  ECS cluster/service with ALB
# Some code was c&p from [terraform github examples](https://github.com/hashicorp/terraform/tree/master/examples) and [best practices](https://github.com/hashicorp/best-practices/)
# Also this assumes you using a CI to update task definition for deploys, hint: use [concourse.ci](https://concourse.ci/)

You will need terraform 0.7.3 at least

## Usage
Clone the repo:

``` shell
git clone git@github.com:jespada/terraform-vpc-ecs.git

cd terraform-vpc-ecs/
```

Create  `terraform.tfvars` file inside and create a symbolic link for each environment:

``` shell
emacs terraform.tfvars
```

with the following content(of course you need to generate an ssh key pair):

``` shell
access_key = "XXXYOU-ACCES_KEY_HERE-XXXXX"

secret_key = "XXXXXXXX-SECRET_KEY_HERE-XXXXXSSSS"

key_path = "/Users/jespada/.ssh/admin-app-prod"

```
Now create a symbolic link:

``` shell
cd base/

ln -s ../terraform.tfvars

cd ..

cd prod/

ln -s ../terraform.tfvars
```

# First time only
Check *NOTE* in the bottom first. Then go on with whats bellow.

Before starting, you need to tell terraform that you will store the state file on an
s3 bucket (cause we decide this way, but its not a must if you are working on your own
projects)

Export AWS key and secret environment variables on your terminal:

``` shell
export AWS_ACCESS_KEY_ID="XXXYOU-ACCES_KEY_HERE-XXXXX"

export AWS_SECRET_ACCESS_KEY="XXXXXXXX-SECRET_KEY_HERE-XXXXXSSSS"
```
Now we instruct terraform to store stuff on s3:

``` shell
make remote
```

Now you can perform `make plan` (for terraform plan) and `make apply` (terraform apply).
Check the Makefile for more information.


## NOTE
If this is the first time you are using this code and none of the resource are created
(vpc, subnets, dns etc) you will need to create an s3 bucket to store terraform state files
in order to do that go to [base](../base/README.md) and follow the instructions.
