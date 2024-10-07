resource "aws_eip" "nat_eip" {
  count = length(var.cidr_private_subnet)
  vpc   = true

  tags = {
    Name    = "Elastic IP for Private Subnet #${count.index + 1}"
    Project = "Task 2"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = length(var.cidr_private_subnet)
  depends_on    = [aws_eip.nat_eip]
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.private_subnets[count.index].id

  tags = {
    Name    = "NAT Gateway for Private Subnet #${count.index + 1}"
    Project = "Task 2"
  }
}