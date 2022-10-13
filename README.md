# terraform-awss3-static-website



## Getting started

This is a sample project which contains a module to setup static website using aws s3 bucket and terraform.

In order to use this project as is to deploy a static website to your aws account s3, follow the below steps.

## In backend.tf file,
- set the bucket name you desired to store state file of your project. (Note: Assuming the bucket is already created manually before running this project).
- set the key name or path for your statefile inside this bucket.
- Specify the Region if different or you can leave the existing one.
```
terraform {
  backend "s3" {
    bucket = "" //terraform state file bucket
    key    = "" // key
    region = "us-east-1" // region
  }
}
```

## In variables.tf file,

```
variable state_bucket {
    type = string
    default = "" //give your terraform statefile bucket
}

variable account_nr {
    type = string
    default = "" //give your aws account number
}

variable "website_bucket" {
    type = string
    default = "" // give bucket name for your website
}

// you can add more tags by comma separated
variable "website_bucket_tags" {
    type = any
    default = {
        name = "sample website hosting"
    }
}

```

Once you have defined all the necessary details as mentioned above, next you can run terraform locally by following below steps:

(NOTE: Assuming Terraform and AWS Cli are installed on your machine)

```
cd terraform

terraform init

terraform plan


terraform apply
```

