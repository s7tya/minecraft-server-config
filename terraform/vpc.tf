
resource "aws_vpc" "minecraft_vpc" {
  cidr_block = "10.1.0.0/24"
}

resource "aws_subnet" "minecraft_subnet" {
  vpc_id                  = aws_vpc.minecraft_vpc.id
  cidr_block              = "10.1.0.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "minecraft_internet_gateway" {
  vpc_id = aws_vpc.minecraft_vpc.id
}

resource "aws_route_table" "minecraft_route" {
  vpc_id = aws_vpc.minecraft_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.minecraft_internet_gateway.id
  }
}

resource "aws_route_table_association" "minecraft_route_association" {
  subnet_id      = aws_subnet.minecraft_subnet.id
  route_table_id = aws_route_table.minecraft_route.id
}
