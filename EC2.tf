# create ec2 instance
resource "aws_instance" "public_ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.tf_key.key_name
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = var.public_ec2_instance_name
  } 
  vpc_security_group_ids = [aws_security_group.web_sg.id]
}


# create ec2 instance in private subnet
resource "aws_instance" "private_ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type 
  key_name = aws_key_pair.tf_key.key_name
  subnet_id     = aws_subnet.private_subnet.id
  tags = {
    Name = var.private_ec2_instance_name
  }
  vpc_security_group_ids = [aws_security_group.web_sg.id]
    user_data = <<-EOF
                #!/bin/bash
                sudo yum install -y httpd
                sudo systemctl start httpd
                sudo systemctl enable httpd     
                echo "Hello, World!" | sudo tee /var/www/html/index.html
                EOF
} 
