# EC2 instance params
variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "svtnk-ec2-s3-instance"
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

# S3 bucket params
variable "s3_bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "svoitenko-bucket-week-3"
}

# RDS params
variable "rds_identifier" {
  description = "Value of the identifier name for the RDS instance"
  type        = string
  default     = "postgres-rds-terraform"
}

variable "rds_allocated_storage" {
  description = "RDS allocated storage value in GBs"
  type        = number
  default     = 20
}

variable "rds_default_username" {
  description = "Name of the default RDS user"
  type        = string
  default     = "postgres"
}

variable "rds_default_user_password" {
  description = "Default RDS user password"
  type        = string
  default     = "testpwd1"
}
