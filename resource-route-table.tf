// CREATE PUBLIC ROUTE TABLE FOR 2 PUBLIC SUBNETS
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.task_2_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_internet_gateway.id
  }

  tags = {
    Name    = "Route Table for Public Subnets"
    Project = "Task 2"
  }
}

// CREATE PRIVATE ROUTE TABLE FOR 2 PRIVATE SUBNETS
resource "aws_route_table" "private_route_table" {
  vpc_id     = aws_vpc.task_2_vpc.id
  depends_on = [aws_nat_gateway.nat_gateway]

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name    = "Route Table for Private Subnets"
    Project = "Task 2"
  }
}