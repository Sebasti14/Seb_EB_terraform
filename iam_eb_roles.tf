# Creating the roles required for Elastic beanstalk ##

resource "aws_iam_role" "eb-ec2-role" {
    name = "eb-ec2-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "eb-ec2-role" {
    name = "eb-ec2-role"
    role = aws_iam_role.eb-ec2-role.name
}

resource "aws_iam_role" "eb-service-role" {
    name = "eb-service-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "elasticbeanstalk.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


## Attaching EB policies to the roles created ##

resource "aws_iam_policy_attachment" "eb-ec2-role-attach" {
    for_each = toset(var.ec2_policies)
    name = "eb-ec2-role-attach-policy-${each.value}"
    roles = [aws_iam_role.ec2-role.name]
    policy_arn = "arn:aws:iam::aws:policy/${each.value}"
}

resource "aws_iam_policy_attachment" "eb-service-role-attach" {
    for_each = toset(var.service_policies)
    name = "eb-service-role-attach-policy-${each.value}"
    roles = [aws_iam_role.eb-service-role.name]
    policy_arn = "arn:aws:iam::aws:policy/service-role/${each.value}"
}
