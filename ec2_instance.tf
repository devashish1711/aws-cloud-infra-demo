# Name: ec2_instance.tf
# Owner: Saurav Mitra
# Description: This terraform config will create an EC2 Instance as Nginx Webserver

# Security Group
resource "aws_security_group" "web_sg" {
  name        = "${var.prefix}_web_sg"
  description = "Security Group for Web Server"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.prefix}-web-sg"
    Owner = var.owner
  }
}

# Ubuntu AMI Filter
# ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20201026
data "aws_ami" "ubuntu" {
  owners      = ["099720109477"] # Canonical
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# SSH Public Key
resource "aws_key_pair" "ssh_key" {
  key_name   = "terraform-aws"
  public_key = var.ssh_public_key
}

# EC2 Instance
resource "aws_instance" "web_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_subnet[0].id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  key_name                    = aws_key_pair.ssh_key.key_name

  ebs_block_device {
    device_name           = "/dev/sda1"
    volume_size           = 30
    delete_on_termination = true
  }

  user_data = file("webserver.sh")

  tags = {
    Name  = "${var.prefix}-web-instance"
    Owner = var.owner
  }
}
