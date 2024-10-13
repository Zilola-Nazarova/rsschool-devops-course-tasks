// CREATE PUBLIC ROUTE TABLE FOR 2 PUBLIC SUBNETS
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.task_2_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_internet_gateway.id
  }

  tags = {
    Name    = "Public Route Table"
    Project = "Task 2"
  }
}

// CREATE 2 PRIVATE ROUTE TABLES FOR 2 PRIVATE SUBNETS
resource "aws_route_table" "private_route_table" {
  count      = length(var.cidr_private_subnet)
  vpc_id     = aws_vpc.task_2_vpc.id
  depends_on = [aws_nat_gateway.nat_gateway]

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }

  tags = {
    Name    = "Private Route Table ${count.index + 1}"
    Project = "Task 2"
  }
}