
## create the security groups required for the VPC and Load balancer ##

resource "aws_security_group" "eb-lb-sg" {
  vpc_id = aws_vpc.main-vpc.id
  name = "eb-lb-sg"
  description = "AWSEB-LBsecuritygroup"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "AWSEB-LBsg"
  }
}

resource "aws_security_group" "eb-vpc-sg" {
  vpc_id = aws_vpc.main-vpc.id
  name = "eb-vpc-sg"
  description = "AWSEB-VPCsecuritygroup"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 123
    to_port = 123
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.eb-lb-sg.id]
  }
  ingress {
    from_port = 123
    to_port = 123
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "AWSEB-VPCsg"
  }
}
