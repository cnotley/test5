output "server_version" {
  value = data.aws_ami.this.name
}

output "ssh_command" {
  value = "ssh [-i <SSH_PRIVATE_KEY_FILEPATH>] ubuntu@${aws_eip.lb.public_ip}"
}

output "instance_public_ip" {
  value = aws_eip.lb.public_ip
}
