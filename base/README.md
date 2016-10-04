# BASE to get started
The idea of base is to create the resource necessary to store your terraform state
files in a remote place, so you can share with other people or modules that need
information about your environment.
We will create an s3 bucket for that purpose and ideally we should define
remote state, but since we don't needed for our own env its commented out for now.

## Usage
We need to create a bucket first:

``` shell
make plan

make apply
```

After the bucket is created we have all resources needed to store terraform state file.

Export AWS key and secret environment variables on your terminal before using it:

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
