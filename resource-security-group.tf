resource "aws_security_group" "security_group" {
  name        = "SG for Task 2 VPC"
  description = "To allow SSH, HTTP, HTTPS inbound traffic"

  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]

  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = "HTTPS from VPC"
      from_port        = 443
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 443
    },
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = "HTTP from VPC"
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    },
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = "SSH from VPC"
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    }
  ]

  vpc_id     = aws_vpc.task_2_vpc.id
  depends_on = [aws_vpc.task_2_vpc]

  tags = {
    Name = "Security Group for Task 2 VPC"
  }
}