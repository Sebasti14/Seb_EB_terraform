## VPC configuration ##

resource "aws_vpc" "main-vpc" {
  cidr_block = var.base_cidr_block
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"

  tags = {
    Name = "main_vpc"
  }
}

## Public Private subnets creation ##

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "az-public" {
  count = var.aws_subnet_count
  vpc_id = aws_vpc.main-vpc.id
  cidr_block = cidrsubnet(aws_vpc.main-vpc.cidr_block, 8, count.index+1)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = "true"
  tags = {
    Name = "main-public-count.index+1"
  }
  depends_on = [
    aws_vpc.main-vpc
  ]
}

resource "aws_subnet" "az-private" {
  count = var.aws_subnet_count
  vpc_id = aws_vpc.main-vpc.id
  cidr_block = cidrsubnet(aws_vpc.main-vpc.cidr_block, 8, count.index+6)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = "false"
  tags = {
    Name = "main-private-count.index+1"
  }
  depends_on = [
    aws_vpc.main-vpc
  ]
}

## Internet gateway, route-table and route-table association ##

resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main-vpc.id
  tags = {
    Name = "main-igw"
  }
  depends_on = [
    aws_vpc.main-vpc
  ]
}

resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }
  tags = {
    Name = "main-public-route"
 }
}

resource "aws_route_table_association" "main-public" {
    count = var.aws_subnet_count
    subnet_id = element(aws_subnet.az-public.*.id,count.index)
    route_table_id = aws_route_table.main-public.id
}
## Following commented lines required in case private instances are required to connect to internet ##

## NAT gateway, route-table and route-table association ##

#resource "aws_eip" "nat" {
#  vpc = true
#}

#resource "aws_nat_gateway" "main-ngw" {
#  allocation_id = aws_eip.nat.id
#  subnet_id = element(aws_subnet.az-public.*.id,0)
#  depends_on = [
#    aws_internet_gateway.main-igw,
#    aws_aubnet.az-public,
#    ]
#}

#resource "aws_route_table" "main-private" {
#  vpc_id = aws_vpc.main-vpc.id
#  route {
#    cidr_block = "0.0.0.0/0"
#    nat_gateway_id = aws_nat_gateway.main-ngw.id
#  }
#  tags = {
#    Name = "main-private-route"
#  }
#}

resource "aws_route_table_association" "main-private-route" {
  count = var.aws_subnet_count
  subnet_id = element(aws_subnet.az-private.*.id,count.index)
  route_table_id = aws_route_table.main-public.id
#  route_table_id = "${aws_route_table.main-private.id}"
}
