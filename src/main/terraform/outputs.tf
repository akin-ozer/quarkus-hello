output "ec2_ip_master" {
  value = aws_instance.web[0].public_ip
}
output "ec2_ip_node" {
  value = aws_instance.web[1].public_ip
}