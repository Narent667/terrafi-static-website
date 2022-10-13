variable s3_hosting_details {
    type = object({
        bucket_name = string,
        tags = any,
        static_site_container = string,
        index_doc = string,
        error_doc = string,
        account_nr = string
    })
}