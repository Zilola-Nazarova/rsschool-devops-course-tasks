# rsschool-devops-course-tasks
This project contains Terraform code and GitHub Actions workflows to manage AWS infrastructure for the RSSchool DevOps course.

## Installations
- AWS CLI (`aws --version`)
- Terraform (`terraform version`)
- tfenv (to manage multiple versions of Terraform)

## IAM User
IAM User has the following policies:
- AmazonEC2FullAccess
- AmazonRoute53FullAccess
- AmazonS3FullAccess
- IAMFullAccess
- AmazonVPCFullAccess
- AmazonSQSFullAccess
- AmazonEventBridgeFullAccess

Multi-Factor Authentication (MFA) is enabled for both the new user and the root user.
A newly generated pair of Access Key ID and Secret Access Key is used for AWS CLI configuration.

## AWS CLI
To configure the AWS CLI using the new user's credentials:
```
aws configure
AWS Access Key ID [None]: accesskey
AWS Secret Access Key [None]: secretkey
Default region name [None]: region
Default output format [None]: json/text/table
```
`aws ec2 describe-instance-types --instance-types t4g.nano` is used to verify the configuration.

## S3 Bucket for Terraform States
S3 bucket is created to store the Terraform state files:
- permissions are set
- bucket versioning enabled
- encryption enabled
DynamoDB table is created to support the locking ("LockID" column)
Backend block was added to Terraform configuration:
```
  backend "s3" {
    bucket         = "rsschool-devops-course-tfstate"
    key            = "state/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    dynamodb_table = "rsschool-devops-sourse-tf-lockid"
  }
```

## IAM Role for GitHub Actions
GithubActionsRole IAM Role has the following policies:
- AmazonEC2FullAccess
- AmazonRoute53FullAccess
- AmazonS3FullAccess
- IAMFullAccess
- AmazonVPCFullAccess
- AmazonSQSFullAccess
- AmazonEventBridgeFullAccess

GitHub OIDC provider was added to IAM  
GithubActionsRole IAM was updated to include a trust policy for GitHub Actions

## Configure GitHub Actions for Terraform Deployment
GitHub Actions workflow includes the following jobs and setups:

`terraform init` to initialize Terraform  
`aws-actions/configure-aws-credentials` to configure AWS credentials using GitHub Actions  
`terraform-check` runs terraform fmt to check the format of Terraform files  
`terraform-plan` runs terraform plan to create a plan for deployment  
`terraform-apply` runs terraform apply to apply the planned changes  

Each job triggers on pull_request and push to the default branch.

## Use
- check the Terraform backend settings in the main.tf file
- run `terraform init` to initialize Terraform.
- to review the changes, run `terraform plan`, then apply them with `terraform apply`.
