
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.16.0/20"
  availability_zone = data.aws_availability_zones.available.names[0]
  


  tags = {
    Name = "Main"
  }
}
 resource "aws_subnet" "subnet1" {
 vpc_id     = aws_vpc.main.id
 cidr_block = "10.1.32.0/20"
 
 availability_zone = data.aws_availability_zones.available.names[1]


   tags = {
     Name = "Main1"
   }
 }
 
