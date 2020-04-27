variable "aws_region" {
  description = "The region of AWS where the app is to be deployed"
  default = "us-east-1"
}

variable "base_cidr_block" {
  description = "The cidr block to create vpc"
  default = "10.0.0.0/16"
}

variable "aws_subnet_count" {
  description = "The number of subnets required in VPC"
  default = "2"
}

variable "ec2_policies" {
  description = "The list of policies to attach to EB EC2 role"
}

variable "service_policies" {
  description = "The list of policies to attach to EB service role"
}

variable "app_name" {
  description = "Name of the application to be deployed in EB"
}

variable "app_stack_name" {
  description = "Name of the solution stack for the application"
}

variable "app_version" {
  description = "Version number for the application"
}

variable "instance_type" {
  description = "The type of EC2 inmstance to be created in EB"
  default = "t2.micro"
}

variable "min_autoscale_num" {
  description = "  Minimum no. of instances required anytime to run in the EB"
  default = 1
}

variable "max_autoscale_num" {
  description = "maximum number upto which the instances can be scaled in EB"
}


