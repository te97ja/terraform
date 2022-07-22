provider "aws" {
  region = var.region
}

# creating new EBS volume with 10gig space
resource "aws_ebs_volume" "newebs" {
  availability_zone = var.availability_zone
  size              = 10
  tags = {
    Name = "10gb volume"
  }
}

# create VPC 
resource "aws_vpc" "main" {
cidr_block = var.vpc_cidr
assign_generated_ipv6_cidr_block = true

# un-hash this to make the vpc default
#instance_tenancy = default

tags = {
Name = "main"
}
}

#creating igw for the vpc
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

# Create the Security Group for the vpc
resource "aws_security_group" "my_vpc" {
  vpc_id       = aws_vpc.main.id
 
  ingress {
    cidr_blocks = var.security_group_cidr
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  } 
  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.security_group_cidr
  }
tags = {
   Name = "My VPC Security Group"
   Description = "My VPC Security Group"
}
}

# creating a new security group for the ec2
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

# creating a subnet for the vpc
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr
  availability_zone = var.availability_zone
  map_public_ip_on_launch = "true"
  tags = {
    Name = "Main"
  }
}

resource "aws_egress_only_internet_gateway" "egress" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

# creating routing table and routes
resource "aws_route_table" "route1" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.egress.id
  }

#  route {
#    cidr_block = "10.0.0.0/16"
#    destination_prefix_list_id = "local"
# }
}

#associating the subnet with routing table
resource "aws_route_table_association" "subnet_route_assoc" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.route1.id
}

# creating aws ec2 instance
resource "aws_instance" "ourfirst" {
  ami           = var.ami
  instance_type = var.instance
  availability_zone = var.availability_zone

#  security_groups= [ aws_security_group.webserver.name ]
  subnet_id = aws_subnet.main.id
  vpc_security_group_ids = [ aws_security_group.my_vpc.id ]
}

# attaching ebs to the ec2
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.newebs.id
  instance_id = aws_instance.ourfirst.id
}

