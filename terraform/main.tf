data "aws_s3_bucket" "statefile_bucket" {
  bucket = var.state_bucket
}

resource "aws_s3_bucket_policy" "allow_access" {
  bucket = data.aws_s3_bucket.statefile_bucket.id
  policy = data.aws_iam_policy_document.allow_access.json
}

data "aws_iam_policy_document" "allow_access" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [var.account_nr]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject"
    ]

    resources = [
      data.aws_s3_bucket.statefile_bucket.arn,
      "${data.aws_s3_bucket.statefile_bucket.arn}/*",
    ]
  }
}


module static_hosting_s3 {
    source="./modules/static_hosting_s3"
    s3_hosting_details = {
        bucket_name = var.website_bucket,
        tags = var.website_bucket_tags,
        static_site_container = "../dist",
        index_doc = "index.html",
        error_doc = "index.html",
        account_nr = var.account_nr
    }

    depends_on = [
      aws_s3_bucket_policy.allow_access
    ]
}