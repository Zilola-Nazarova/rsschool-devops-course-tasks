# rsschool-devops-course-tasks
This project contains Terraform code, GitHub Actions workflows to manage AWS and Kubernetes infrastructure.

## Description
### IAM User
IAM User is created with multi-Factor Authentication (MFA) enabled for both the new user and the root user. The policies are added to IAM user.

A newly generated pair of Access Key ID and Secret Access Key is used for AWS CLI configuration.

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

### Installations
- AWS CLI (check with `aws --version`)
- Terraform (check with `terraform version`)
- tfenv (to manage multiple versions of Terraform)
- [kubectl](https://kubernetes.io/docs/tasks/tools/) (check with `kubectl version`)
- [kops](https://kops.sigs.k8s.io/getting_started/install/) (check with `kops version`)
- [jq](https://jqlang.github.io/jq/download/) (check with `jq --version`)

### Setup
Configure your AWS credentials:
```
aws configure
AWS Access Key ID [None]: <accesskey>
AWS Secret Access Key [None]: <secretkey>
Default region name [None]: <region>
Default output format [None]: <json/text/table>
```

### Creating Resources
Run `terraform init` to initialize Terraform.  
Run `terraform-fmt` to check/fix terraform code formatting. 
Run `terraform-plan` and `terraform-apply` to apply your terraform code.  

### Connecting to Instances
If EC2 instances have been created in previous steps you should be able to connect to AWS instances via SSH:
```
eval $(ssh-agent)
ssh-add </path/to/key>
ssh -A ec2-user@<BastionIP_Adress>
ssh ec2-user@<Private_Instance_IP_address>
```

### Kubernetes
Export your credentials for kops to use:
> export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
> export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)

You can create your cluster:
1. Manually
2. By running `regen-cluster.sh`

**1. Manually**
  Export environment variables to make the process easier:
  ```
  export NAME=myfirstcluster.k8s.local
  export KOPS_STATE_STORE=s3://prefix-example-com-state-store
  ```
  In this project, gossip-based cluster is used.

  Create a cluster:
  ```
  kops create cluster --name=${NAME} --cloud=aws --zones=eu-north-1a --discovery-store=s3://task3-kops-state-bucket/${NAME}/discovery
  ```
  Open in editor and customize your cluster (optional):
  ```
  kops edit cluster --name ${NAME}
  ```
  Build your cluster:
  ```
  kops update cluster --name ${NAME} --yes --admin
  ```
**Running regen-cluster.yaml**
  Run `regen-cluster.sh` script

In case kops asks for Password run `kops export kubecfg --admin`

Validate that cluster was created successfully:
```
kops validate cluster
```
Check if the API is online and listening:
```
kubectl get nodes
```
Apply your deployment YAML file:
```
kubectl apply -f https://k8s.io/examples/application/deployment-scale.yaml
```
(we used an example from https://kubernetes.io/)
Verify that the Deployment has four Pods:
```
kubectl get pods -l app=nginx
```
Create a Service object that exposes the deployment:
```
kubectl expose deployment nginx-deployment -type=LoadBalancer --name=my-service
```
Display information about the Service:
```
kubectl get service
```
Use the external IP address (LoadBalancer Ingress) to access the application:
```
curl <externalIP>
```
Delete your resources when you are finished running experiments:
```
kubectl delete services my-service
kubectl delete deployment nginx-deployment
kops delete cluster --name ${NAME} --yes
terraform desrtoy
```

## Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).


## Show your support

If you like this project just star it!


## Acknowledgments

This project was developed as part of the [RSSchool](https://rs.school/courses/aws-devops) AWS DevOps course. I would like to express my gratitude to the RSSchool team for their guidance and support throughout the learning journey.
