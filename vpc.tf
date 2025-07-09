
# create a VPC
resource "aws_vpc" "vpc-1" {
  cidr_block = var.cidr_block_vpc-1
}
# create a public subnet in the VPC
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc-1.id
  cidr_block = var.cidr_block_public_subnet
  availability_zone = var.pub_availability_zone
  map_public_ip_on_launch = true

  }

# create private subnet in the VPC
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc-1.id
  cidr_block = var.cidr_block_private_subnet
  availability_zone = var.priv_availability_zone
}





# Create an internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-1.id
}
# NAT Gateway in a public subnet 
resource "aws_eip" "nat_eip" {
}
resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
}






# create a route table for the public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc-1.id 
}
# create a route to the internet gateway in the public route table
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = var.destination_cidr_block
  gateway_id             = aws_internet_gateway.igw.id
}
# associate the public route table with the public subnet
resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}






# create a route table for the private subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc-1.id
  }
# create a route to the nat gateway in the private route table
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = var.destination_cidr_block
  gateway_id             = aws_nat_gateway.gw.id
}
# associate the private route table with the private subnet
resource "aws_route_table_association" "private_subnet_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}   


