# Create a bucket
resource "aws_s3_bucket" "static-bucket" {

  bucket = var.s3_hosting_details.bucket_name

  lifecycle {
    prevent_destroy = true
  }

  tags = var.s3_hosting_details.tags

}

resource "aws_s3_bucket_acl" "static-bucket_acl" {
  bucket = aws_s3_bucket.static-bucket.id
  acl    = "public-read"
}

resource "null_resource" "remove_and_upload_to_s3" {
    triggers = {
        build_number = "${timestamp()}"
    }
    provisioner "local-exec" {
        command = "aws s3 sync ${var.s3_hosting_details.static_site_container} s3://${aws_s3_bucket.static-bucket.id}"
    }

    depends_on = [
        aws_s3_bucket.static-bucket
    ]
}

#setup static website config
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.static-bucket.bucket

  index_document {
    suffix = var.s3_hosting_details.index_doc
  }

  error_document {
    key = var.s3_hosting_details.error_doc
  }

  depends_on = [
    aws_s3_bucket.static-bucket,
    null_resource.remove_and_upload_to_s3
  ]
}

resource "aws_s3_bucket_policy" "allow_access" {
  bucket = aws_s3_bucket.static-bucket.id
  policy = data.aws_iam_policy_document.allow_access.json

  depends_on = [
    aws_s3_bucket.static-bucket
  ]
}

data "aws_iam_policy_document" "allow_access" {
  statement {
    sid="PublicReadGetObject"
    principals {
        type="*"
        identifiers = ["*"]
    }
    actions = ["*"]
    resources = [
      aws_s3_bucket.static-bucket.arn,
      "${aws_s3_bucket.static-bucket.arn}/*",
    ]
  }

  depends_on = [
    aws_s3_bucket.static-bucket
  ]
}
