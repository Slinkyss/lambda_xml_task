resource "aws_internet_gateway" "gw1" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}




resource "aws_vpc" "main" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  



  tags = {
    Name = "main"
  }
 
}


