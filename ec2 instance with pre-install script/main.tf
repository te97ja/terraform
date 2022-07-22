#to create multiple reasons in multiple regions
provider "aws" {
  region     = "us-west-2"
}

#security group initializing
resource "aws_security_group" "webserver_access" {
        name = "webserver_access"
        description = "allow ssh and http"

        ingress {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }

resource "aws_vpc" "main" {
cidr_block = "10.0.0.0/16"
}

}
#security group end here

resource "aws_instance" "ourfirst" {
  ami           = "ami-0cb4e786f15603b0d"
#  availability_zone = "us-west-2a"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.webserver_access.name}"]
  key_name = "aws1"
  tags = {
    Name  = "ec2_EBS_vpc"
    Stage = "testing"
    Location = "Oregon"
  }

}
