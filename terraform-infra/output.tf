output "ec2_public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "ec2_public_dn" {
  value = aws_instance.my_instance.public_dns
}

output "ec2_private_ip" {
  value = aws_instance.my_instance.private_ip
}

output "ssh_command" {
  value = "ssh -i ${path.module}/../keys/terra-ec2-key ubuntu@${aws_instance.my_instance.public_ip}"
}
