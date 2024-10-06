resource "aws_subnet" "task_2_public_subnets" {
  count             = length(var.cidr_public_subnet)
  vpc_id            = aws_vpc.task_2_vpc.id
  cidr_block        = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.eu_availability_zone, count.index)

  tags = {
    Name = "Task 2 Subnet Public #${count.index + 1}"
  }
}

resource "aws_subnet" "task_2_private_subnets" {
  count             = length(var.cidr_private_subnet)
  vpc_id            = aws_vpc.task_2_vpc.id
  cidr_block        = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.eu_availability_zone, count.index)

  tags = {
    Name = "Task 2 Subnet Private #${count.index + 1}"
  }
}