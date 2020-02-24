resource "aws_instance" "web" {
  count = var.instance_count
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  key_name = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [
    aws_security_group.public.id]
  subnet_id = aws_subnet.public.id
  associate_public_ip_address = true
  tags = {
    Name = "web-${count.index + 1}"
  }
}