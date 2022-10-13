variable state_bucket {
    type = string
    default = "nt-infra-dev-bucket55" //give your terraform statefile bucket
}

variable account_nr {
    type = string
    default = "768682817835" //give your account number
}

variable "website_bucket" {
    type = string
    default = "nt-infra-static-website"
}

variable "website_bucket_tags" {
    type = any
    default = {
        name = "static website"
        environment = "dev"
    }
}
