terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.18.0"
    }
  }

  backend "s3" {
    bucket = "rsschool-devops-course-tfstate"
    key = "state/terraform.tfstate"
    region = "eu-north-1"
    encrypt = true
    dynamodb_table = "rsschool-devops-sourse-tf-lockid"
  }
}