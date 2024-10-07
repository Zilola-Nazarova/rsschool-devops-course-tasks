data "aws_subnet" "public_subnet" { // fetches public_subnets resource
  filter {
    name   = "tag:Name"
    values = ["Public Subnet #1"]
  }

  depends_on = [
    aws_route_table_association.public_subnet_association
  ]
}

resource "aws_instance" "ec2_in_subnet_1" {
  ami           = var.aws_linux_ami
  instance_type = var.aws_linux_instance_type

  tags = {
    Name = "EC2 for Public Subnet #1"
  }

  subnet_id              = data.aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.security_group.id]
}
