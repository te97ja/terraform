provider "aws" {
  region = var.region
}
resource "aws_ebs_volume" "newebs" {
  availability_zone = var.availability_zone
  size              = 10

  tags = {
    Name = "10gb volume"
  }
}

resource "aws_vpc" "main" {
cidr_block = var.vpc_cidr
#instance_tenancy = default
tags = {
Name = "main"
}
}

resource "aws_security_group" "webserver" {
        name = "webserver"
        vpc_id = aws_vpc.main.id
        description = "allow ssh and http"

        ingress {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = var.security_group_cidr
        }

        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = var.security_group_cidr
        }

        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = var.security_group_cidr
        }
}

resource "aws_instance" "ourfirst" {
  ami           = var.ami
  instance_type = var.instance
  availability_zone = var.availability_zone

   security_groups= [ "terraform" ]
#  subnet_id = aws_subnet.main.id
#  vpc_security_group_ids = [ aws_security_group.my_vpc.id ]
}
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.newebs.id
  instance_id = aws_instance.ourfirst.id
}
