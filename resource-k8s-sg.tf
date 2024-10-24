resource "aws_security_group" "k8s_sg" {
  name   = "k8s_sg"
  vpc_id = aws_vpc.task_2_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.100/32", "10.0.0.101/32"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.100/32", "10.0.0.101/32"]
  }

  tags = {
    Name    = "Security Group for K8S Cluster"
    Project = "Task 3"
  }
}