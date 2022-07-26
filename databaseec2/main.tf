provider "aws" {
  region     = "us-west-2"
}

resource "aws_instance" "ourfirst" {
  count=1
  ami           = "ami-0ddf424f81ddb0720"
  instance_type = "t2.micro"
  security_groups= ["launch-wizard-1"]
  key_name = "aws1"
}

resource "aws_db_instance" "mysqldb" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  db_name              = "mydb"
  username             = "admin"
  password             = "123456789"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  identifier           = "mysqldb"
}
