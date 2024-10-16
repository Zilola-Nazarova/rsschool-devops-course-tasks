# rsschool-devops-course-tasks
This project contains Terraform code and GitHub Actions workflows to manage AWS infrastructure for the RSSchool DevOps course.

## Installations
- AWS CLI (`aws --version`)
- Terraform (`terraform version`)
- tfenv (to manage multiple versions of Terraform)

## Workflow
### IAM User
IAM User is created with multi-Factor Authentication (MFA) enabled for both the new user and the root user. The policies are added to IAM user.

A newly generated pair of Access Key ID and Secret Access Key is used for AWS CLI configuration:
```
aws configure
AWS Access Key ID [None]: accesskey
AWS Secret Access Key [None]: secretkey
Default region name [None]: region
Default output format [None]: json/text/table
```
`aws ec2 describe-instance-types --instance-types t4g.nano` is used to verify the configuration.

### S3 Bucket for Terraform States
S3 bucket is created to store the Terraform state files:
- permissions are set
- bucket versioning enabled
- encryption enabled
DynamoDB table is created to support the locking ("LockID" column)
Backend block was added to Terraform configuration.

### IAM Role for GitHub Actions
- GithubActionsRole IAM Role was created with corresponding policies attached
- GitHub OIDC provider was added to IAM  
- GithubActionsRole IAM was updated to include a trust policy for GitHub Actions

### GitHub Actions for Terraform Deployment
GitHub Actions workflow includes the following jobs and setups:

`terraform init` to initialize Terraform  
`terraform-check` runs terraform fmt to check the format of Terraform files  
`terraform-plan` runs terraform plan to create a plan for deployment  
`terraform-apply` runs terraform apply to apply the planned changes  

Each job triggers on `pull_request` and `push` to the default branch.

## Architecture
- VPC (Virtual Private Cloud):
  - Internet Gateway
  - Availability Zone 1 (AZ1)
    - Public Subnet (Bastion)
      - EC2
      - NAT Gateway & EIP
    - Private Subnet
      - EC2
  - Availability Zone 2 (AZ2)
    - Public Subnet
      - EC2
    - Private Subnet
      - EC2

**Public Subnets** contain resources that need direct access to the Internet, such as Bastion hosts or Virtual Machines (VMs) with both public and private IPs. Bastion Host is located in the public subnet and is used to securely connect to the VMs in the private subnet.

**Private Subnet** contain resources that do not need direct Internet access, such as internal VMs. Traffic from the private subnet is routed through the NAT Gateway.

**Security Groups** and **ACLs** are configured to control access to resources.

## Use
To connect to AWS instances via SSH:
```
eval $(ssh-agent)
ssh-add </path/to/key>
ssh -A ec2-user@<BastionIP_Adress>
ssh ec2-user@<Private_Instance_IP_address>
```
To apply changes in Terraform code:
- check the Terraform code and run `terraform fmt` to format
- run `terraform init` to initialize Terraform
- to review the changes, run `terraform plan`, then apply them with `terraform apply`


## Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).


## Show your support

If you like this project just star it!


## Acknowledgments

This project was developed as part of the [RSSchool](https://rs.school/courses/aws-devops) AWS DevOps course. I would like to express my gratitude to the RSSchool team for their guidance and support throughout the learning journey.

