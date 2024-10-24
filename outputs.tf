output "region" {
  value = var.aws_region
}

output "vpc_id" {
  value = aws_vpc.task_2_vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.task_2_vpc.cidr_block
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.nat_gateway.allocation_id
}

// used in cluster.yaml
output "availability_zones" {
  value = var.eu_availability_zone
}

output "k8s_sg_id" {
  value = aws_security_group.k8s_sg.id
}

output "kops_s3_bucket" {
  value = aws_s3_bucket.kops_state.id
}

output "k8s_cluster_name" {
  value = var.k8s_cluster_name
}
