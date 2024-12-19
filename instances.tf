# INSTANCES #
resource "aws_instance" "nginx" {
  ami                    = "ami-01816d07b1128cd2d"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_subnet1.id
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  user_data = file("startup_script.tpl")
  tags = {
    Name = "nginx"
  }
}
