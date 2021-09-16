# Name: outputs.tf
# Owner: Saurav Mitra
# Description: Outputs the VPC & Subnet ARNs
# https://www.terraform.io/docs/configuration/outputs.html

output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "The VPC ID."
}

output "public_subnet_id" {
  value       = aws_subnet.public_subnet.*.id
  description = "The public subnets ID."
}

output "private_subnet_id" {
  value       = aws_subnet.private_subnet.*.id
  description = "The private subnets ID."
}

output "vpc_cidr_block" {
  value       = var.vpc_cidr_block
  description = "The address space that is used by the virtual network."
}

output "web_public_ip_address" {
  value       = aws_instance.web_instance.public_ip
  description = "The EC2 Instance Public IP Address."
}
