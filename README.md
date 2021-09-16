# Multi-Cloud AWS Infra:

Configure infrastructure in AWS using Terraform. This is part of the Multi Cloud Demo infra setup for Enterprise Terraform workspace

## Resources

- 1 Virtual Private Cloud
- 3 Private Subnets
- 3 Public Subnets
- 1 Internet Gateway
- 1 NAT Gateway for outbound internet access
- 1 Elastic IP for NAT Gateway
- 2 Routing tables (for Public and Private subnet for routing the traffic)
- 1 EC2 Instance as Nginx Web Server (with corresponding Security Group & SSH Key)
