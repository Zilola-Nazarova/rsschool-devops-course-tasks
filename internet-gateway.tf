resource "aws_internet_gateway" "public_internet_gateway" {
  vpc_id = aws_vpc.task_2_vpc.id

  tags = {
    Name = "Task 2 Internet Gateway"
  }
}