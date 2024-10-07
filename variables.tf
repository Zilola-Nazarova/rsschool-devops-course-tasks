variable "aws_region" {
  description = "AWS provider region"
  type        = string
  default     = "eu-north-1"
}

variable "aws_main_server_ami" {
  description = "AWS main server AMI"
  type        = string
  default     = "ami-000defd1c33d4d17b"
}

variable "aws_main_server_instance_type" {
  description = "AWS main server instance type"
  type        = string
  default     = "t3.micro"
}

variable "aws_s3_bucket" {
  description = "AWS S3 bucket name"
  type        = string
  default     = "rsschool-devops-course-tfstate"
}

variable "aws_s3_key_path" {
  description = "AWS S3 state file path"
  type        = string
  default     = "state/terraform.tfstate"
}

variable "aws_s3_dynamodb_table" {
  description = "AWS S3 DynamoDB table"
  type        = string
  default     = "rsschool-devops-sourse-tf-lockid"
}

variable "aws_iam_github_actions_role" {
  description = "IAM role for GitHub Actions"
  type        = string
  default     = "GithubActionsRole"
}