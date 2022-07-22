

variable "ami"{
type = string
default = "ami-0ddf424f81ddb0720"
}

variable "availability_zone" {
type = string
default = "us-west-2a"
}


variable "region" {
type = string
default = "us-west-2"
}


variable "vpc_cidr" {
default = "10.0.0.0/16"
}

variable "subnet_cidr" {
default = "10.0.0.0/28"
}

variable "security_group_cidr" {
default = [ "0.0.0.0/0" ]
}

variable "instance" {
type = string
default = "t2.micro"
}

