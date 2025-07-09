output "public_ip_of_public_instance" {
  value =  aws_instance.public_ec2_instance.public_ip
       
}
output "private_ip_of_public_instance" {
  value =  aws_instance.public_ec2_instance.private_ip
}





output "private_ip_of_private_instance" {
  value = aws_instance.private_ec2_instance.private_ip
}
output "aws_eip" {
  value = aws_eip.nat_eip.public_ip
}

