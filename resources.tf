resource "aws_instance" "main_server" {
  ami           = "ami-000defd1c33d4d17b"
  instance_type = "t3.micro"

  tags = {
    Name = "MainInstance"
  }
}
