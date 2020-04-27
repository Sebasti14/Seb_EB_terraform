# Seb_EB_terraform

Creates an ELastic Beanstalk (EB) environment with all the required resources from scratch and to deploy an appliaction in it.

Resources created:
- VPC and Subnets (public and private)
- Internet and NAT gateway
- Security groups (VPC and Load balancer)
- IAM roles for EB
- S3 bucket to store the application code as well as the Application logs
- EC2 key pair to access the instance
- Elastic beanstalk environment
