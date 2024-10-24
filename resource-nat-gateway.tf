resource "aws_eip" "nat_eip" {
  vpc   = true

  tags = {
    Name    = "Elastic IP for NAT Gateway"
    Project = "Task 2"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  depends_on    = [aws_eip.nat_eip]
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name    = "NAT Gateway in Public Subnet #1 (Bastion)"
    Project = "Task 2"
  }
}
