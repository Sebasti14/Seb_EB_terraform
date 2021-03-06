aws_region = "us-east-1"
base_cidr_block = "10.0.0.0/16"
aws_subnet_count = 2
instance_type = "t2.micro"
ec2_policies = ["AWSElasticBeanstalkWebTier","AWSElasticBeanstalkMulticontainerDocker","AWSElasticBeanstalkWorkerTier"]
service_policies = ["AWSElasticBeanstalkEnhancedHealth","AWSElasticBeanstalkService"]
app_version = "1.1"
app_name = "sample"
app_stack_name = "64bit Amazon Linux 2018.03 v3.3.4 running Tomcat 8.5 Java 8"
min_autoscale_num = 2
max_autoscale_num = 4
