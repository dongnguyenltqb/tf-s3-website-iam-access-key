## terraform

include:

- S3 bucket
- S3 resource policy base for public read access
- S3 website config
- IAM identity policy for iam user
- IAM user with access_key, secret_key

```shell
	tf apply -var-file=dev.tfvars
```
