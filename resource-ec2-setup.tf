resource "aws_instance" "ec2_public" {
  count         = length(var.cidr_public_subnet)
  ami           = var.aws_linux_ami
  instance_type = var.aws_linux_instance_type

  subnet_id              = element(aws_subnet.public_subnets[*].id, count.index)
  vpc_security_group_ids = [aws_security_group.public_sg.id]

  key_name = var.ssh_pubkey_name

  tags = {
    Name    = "EC2 in Public Subnet #${count.index + 1}"
    Project = "Task 2"
  }

  associate_public_ip_address = true
}

resource "aws_instance" "ec2_private" {
  count         = length(var.cidr_private_subnet)
  ami           = var.aws_linux_ami
  instance_type = var.aws_linux_instance_type

  subnet_id              = element(aws_subnet.private_subnets[*].id, count.index)
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  key_name = var.ssh_pubkey_name

  tags = {
    Name    = "EC2 in Private Subnet #${count.index + 1}"
    Project = "Task 2"
  }
}

resource "aws_key_pair" "aws_auth" {
  key_name   = var.ssh_pubkey_name
  public_key = file(var.ssh_pubkey_path)
}
