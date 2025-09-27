# keypair.tf

variable "key_name" {
  description = "EC2 key pair name"
  default     = "terra-ec2-key"  # <-- must be static
}

variable "public_key_path" {
  description = "Path to your SSH public key"
  default     = "~/.ssh/id_rsa.pub"
}

resource "aws_key_pair" "deployer" {
  # You can use terraform.workspace here to make it unique
  key_name   = "${var.key_name}-${terraform.workspace}"
  public_key = file(var.public_key_path)
}
