provider "aws" {
  region     = "us-west-2"
}

resource "aws_instance" "ourfirst" {
  count=1
  ami           = "ami-098e42ae54c764c35"
  instance_type = "t2.micro"
  security_groups= ["terraform"]
  key_name = "aws1"
}

#resource "aws_instance" "oursecond" {
#  count=1
#  ami           = "ami-098e42ae54c764c35"
#  instance_type = "t2.micro"
#  security_groups= ["terraform"]
#}
