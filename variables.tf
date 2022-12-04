variable "aws_region" {
    description = "AWS Region"
    type = string
    default = "ap-southeast-2"
}


variable "aws_access_key" {
    description = "AWS Access Key"
    type = string
    default = null  
}

variable "aws_secret_key" {
    description = "AWS Secret Key"
    type = string
    default = null
}

variable "vpc_cidr" {
    description = "VPC CIDR'"
    type = string
    default = "10.0.0.0/16"
}

variable "name" {
    description = "Name for Resources / EC instance"
    type = string
    default = "mo-tech-test-displayr"
}

variable "azs" {
    description = "A list of Availability zones for the vpc to deploy resources"
    type = string
    default = "ap-southeast-2b" 
}

variable "public_subnet_cidr" {
    description = "CIDR block for the public subnet, dfault is /28 for 16 total hosts"
    type = string
    default = "10.0.101.0/28"
  
}

variable "instance_type" {
    description = "Default AWS EC2 Instance Type"
    type = string
    default = "t3.micro"
  
}

variable "instance_keypair" {
    description = "AWS EC2 Pre-creted Keypair"
    type = string
    default = null 
}