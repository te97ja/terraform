provider "aws" {
  region     = "us-west-1"
}

resource "aws_instance" "ourfirst" {
  count=1
  ami           = "ami-04fdd35cd0ea7a761"
  instance_type = "t2.micro"
}

