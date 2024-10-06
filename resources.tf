resource "aws_instance" "main_server" {
  count         = 1
  ami           = var.aws_main_server_ami
  instance_type = var.aws_main_server_instance_type

  tags = {
    Name    = "My Amazon Linux"
    Owner   = "Zilola Nazarova"
    Project = "Devops Course Task 1"
  }
}

resource "aws_vpc" "task_2_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "My VPC for task_2"
  }
}
