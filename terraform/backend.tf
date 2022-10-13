terraform {
  backend "s3" {
    bucket = "nt-infra-dev-bucket55" //terraform state file bucket
    key    = "static-site/dev/terraform.tfstate" // key
    region = "us-east-1" // region
  }
}
