# FALCON-PROTOCOL SERVED

variable "name_prefix" {
  type        = string
  description = "Application prefix"
}
variable "ec2_image_name" {
  type        = string
  description = "EC2 image name"
  default     = "ubuntu-focal-20.04"
}

variable "ec2_instance_size" {
  type        = string
  description = "EC2 size"
  default     = "t2.micro"
}

variable "vpc_id" {
  type        = string
  description = "The VPC to deploy the stack into"
}

variable "public_subnet_ids" {
  type        = list(any)
  description = "The public Subnets to deploy the stack into. Only the first will be used"
}

variable "install_script" {
  type        = string
  description = "Scripts to run after EC2 launch"
  default     = ""
}

variable "iam_role_name" {
  type        = string
  description = "The IAM role to use for the stack"
}

variable "kms_key_arn" {
  type        = string
  description = "KMS key ARN"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID"
}


# USER-PROVIDED

variable "admin_user_pub_key" {
  type        = string
  description = "The public SSH key to associate access with the admin user for all VMs"
}

variable "tags" {
  description = "Tags applied to the provisioned resources"
  type        = map(string)
  default     = {}
}
