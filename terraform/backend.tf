terraform {
  backend "s3" {
    bucket = "" //terraform state file bucket
    key    = "" // key
    region = "us-east-1" // region
  }
}

//naren-terraform-state-files
//statics3sites/samplehosting