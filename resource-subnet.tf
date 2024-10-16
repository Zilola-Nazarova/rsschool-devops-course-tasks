// CREATE 2 PUPLIC SUBNETS FOR 2 DIFFERENT AZS
resource "aws_subnet" "public_subnets" {
  count             = length(var.cidr_public_subnet)
  vpc_id            = aws_vpc.task_2_vpc.id
  cidr_block        = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.eu_availability_zone, count.index)

  tags = {
    Name = "Public Subnet #${count.index + 1}"
  }
}

// CREATE 2 PRIVATE SUBNETS FOR 2 DIFFERENT AZS
resource "aws_subnet" "private_subnets" {
  count             = length(var.cidr_private_subnet)
  vpc_id            = aws_vpc.task_2_vpc.id
  cidr_block        = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.eu_availability_zone, count.index)

  tags = {
    Name = "Private Subnet #${count.index + 1}"
  }
}