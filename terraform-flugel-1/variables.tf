
variable "instance_name" {
  description = "The Name tag to set for the EC2 Instance."
  type        = string
}

variable "region" {
  description = "The region where resources will be running"
  type = string
}

variable "instance_type" {
  description = "The EC2 instance type to run."
  type        = string
  default     = "t2.micro"
}

variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  
}

variable "bucket_name" {
  description = "The Name tag to set for the S3 bucket"
  type = string 
}