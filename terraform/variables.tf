variable state_bucket {
    type = string
    default = "" //give your terraform statefile bucket
}

variable account_nr {
    type = string
    default = "" //give your account number
}

variable "website_bucket" {
    type = string
    default = ""
}

variable "website_bucket_tags" {
    type = any
    default = {
        name = "sample website hosting"
    }
}