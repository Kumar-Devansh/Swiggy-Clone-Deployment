variable "env" {
  default = "dev"
  type = string
  description = "This is dev env"
}

variable "ec2_instance_type" { 
    default = "t3.medium"
    type = string
    description = "The type of EC2 instance to use"
}

variable "ec2_default_root_storage_size" {
    default = 30
    type = number
}

variable "ec2_ami_id" {
    default = "ami-0198cdf7458a7a932" # ohio Ubuntu 22.04 LTS
    type = string
    description = "The AMI ID for the EC2 instance"
}