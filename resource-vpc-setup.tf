// CREATE 1 VPC FOR ALL 4 SUBNETS
resource "aws_vpc" "task_2_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "Task 2 VPC"
  }
}
