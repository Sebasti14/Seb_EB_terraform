## Create the key pair to access the EC2 instance ##

## Uncomment below lines only if we need to access the Ec2 instance ##

#resource "aws_key_pair" "eb-ec2-key-pair" {
#  key_name_prefix = "EB-${var.app_name}-key"
#  public_key = file("${path.module}/pub_key")
#}
