resource "aws_instance" "example" {
  ami           = "ami-00f07845aed8c0ee7" # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}
