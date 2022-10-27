variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "svtnk_ec2_s3_instance"
}

variable "instance_type" {
  description = "EC2 instance type configuration"
  type        = string
  default     = "t2.micro"
  validation {
    condition     = contains(["t2.micro", "t2.small", "t2.medium"], var.instance_type)
    error_message = "EC2 instance type is incorrect. Allowed values: t2.micro, t2.small, t2.medium"
  }
}

variable "instance_amiId" {
  description = "AMI identifier of the image to deploy for the EC2 instance"
  type        = string
  default     = "ami-08e2d37b6a0129927"
}

variable "instance_key_name" {
  description = "EC2 instance SSH key"
  type        = string
  default     = "svoitenko-key-pair"
}

variable "s3_bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "svoitenko-bucket-1"
}

variable "file_key_s3" {
  description = "File name laying on defined S3 bucket"
  type        = string
  default     = "test_file.txt"
}
