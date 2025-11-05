resource "aws_vpc" "project-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "project-vpc"
  }
}
resource "aws_subnet" "project-vpc-public-1" {
  vpc_id                  = aws_vpc.project-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}
resource "aws_subnet" "project-vpc-public-2" {
  vpc_id            = aws_vpc.project-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

}
resource "aws_subnet" "project-vpc-public-3" {
  vpc_id            = aws_vpc.project-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1c"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.project-vpc.id
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.project-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.project-vpc-public-1.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route_table_association" "a2" {
  subnet_id      = aws_subnet.project-vpc-public-2.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route_table_association" "a3" {
  subnet_id      = aws_subnet.project-vpc-public-3.id
  route_table_id = aws_route_table.public-rt.id
}


