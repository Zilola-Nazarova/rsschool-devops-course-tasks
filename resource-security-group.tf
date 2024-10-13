// CREATE PUBLIC SECURITY GROUP FOR PUBLIC SUBNETS
resource "aws_security_group" "public_sg" {
  name        = "public-sg"
  description = "Public internet access"
  vpc_id      = aws_vpc.task_2_vpc.id
  depends_on  = [aws_vpc.task_2_vpc]

  tags = {
    Name    = "Public Security Group for VPC"
    Project = "Task 2"
  }
}

// ALLOW ALL OUTBOUND TRAFFIC UNRESTRICTED
resource "aws_security_group_rule" "public_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.public_sg.id
}

// ALLOW INBOUND TRAFFIC: SSH, HTTP, HTTPS
resource "aws_security_group_rule" "public_in_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.public_sg.id
}

resource "aws_security_group_rule" "public_in_http" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.public_sg.id
}

resource "aws_security_group_rule" "public_in_https" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.public_sg.id
}

// CREATE PRIVATE SECURITY GROUP FOR PRIVATE SUBNETS
resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Private internet access"
  vpc_id      = aws_vpc.task_2_vpc.id
  depends_on  = [aws_vpc.task_2_vpc]

  tags = {
    Name    = "Private Security Group for VPC"
    Project = "Task 2"
  }
}

// ALLOW ALL OUTBOUND TRAFFIC UNRESTRICTED
resource "aws_security_group_rule" "private_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.private_sg.id
}

// RESTRICT INBOUND TRAFFIC TO VPC'S CIDR BLOCKS
resource "aws_security_group_rule" "private_in_ssh" {
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "-1"
  cidr_blocks = [aws_vpc.task_2_vpc.cidr_block]

  security_group_id = aws_security_group.private_sg.id
}
