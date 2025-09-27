resource "aws_key_pair" "my_key" {
  key_name   = "terra-ec2-key"
  public_key = file("${path.module}/../keys/terra-ec2-key.pub") # ✅ correct path
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "my_security" {
  name        = "automate"
  description = "this is automate"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "automate"
  }
}

resource "aws_instance" "my_instance" {
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security.name]
  instance_type   = var.ec2_instance_type
  ami             = var.ec2_ami_id
  user_data       = file("${path.module}/install-all.sh") # ✅ path safe

  # First remote-exec
  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/ubuntu/prom-grafana-setup"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/../keys/terra-ec2-key") # ✅ correct path
      host        = self.public_ip
    }
  }

  # Copy monitoring files
  provisioner "file" {
    source      = "${path.module}/../monitoring-files/" # ✅ relative to module
    destination = "/home/ubuntu/prom-grafana-setup/"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/../keys/terra-ec2-key")
      host        = self.public_ip
    }
  }

  root_block_device {
    volume_size = var.ec2_root_storage_size
    volume_type = "gp3"
  }

  tags = {
    Name = "rakesh-terra"
  }
}
