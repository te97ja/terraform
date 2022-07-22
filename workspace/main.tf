locals {
env = "${terraform.workspace}"

counts = {
"developers" = 1
"test" = 2
"deploy" = 2
}

instances = {
"developers" = "t2.micro"
"test" = "t2.micro"
"deploy" = "t2.small"
}

availability = {
"developers" = "us-west-2a"
"test" = "us-west-2b"
"deploy" = "us-west-2c"
}

tags = {
"developers" = "developer"
"test" = "test"
"deploy" = "deploy"
}

instance_type = "${lookup(local.instances,local.env)}"
availability_zone = "${lookup(local.availability,local.env)}"
count = "${lookup(local.counts,local.env)}"
tag = "${lookup(local.tags,local.env)}"
}
       
resource "aws_instance" "multi_workspace" {
ami = var.ami
availability_zone = "${local.availability_zone}"
instance_type = "${local.instance_type}"
count = "${local.count}"
tags = {
Name = "${local.tag}"
}
}
