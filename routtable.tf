resource "aws_default_route_table" "route_table" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw1.id
  }

  tags = {
    Name = "routing_table"
  }
}
resource "aws_main_route_table_association" "route_table_a" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_default_route_table.route_table.id
}


