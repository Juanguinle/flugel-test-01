output "instance_id" {
  value = aws_instance.instance_name.id
}

output "bucket_id" {
  value = aws_s3_bucket.bucket_name.id
}

