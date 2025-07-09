#create security group for the instance
resource "aws_security_group" "web_sg" {
  name        = var.ec2_security_group_name
  description = var.ec2_security_group_description
  vpc_id      = aws_vpc.vpc-1.id    
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = [var.allowed_cidr_block]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.allowed_cidr_block]
    }

    egress {    
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [var.allowed_cidr_block]  
    }
    tags = {
        Name = var.ec2_security_group_name
    }
}








