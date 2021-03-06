## Wait for the EB environment to be Ready ##

resource "null_resource" "sleep" {
  provisioner "local-exec" {
  command = "sleep 10"
  }
  depends_on = [
    aws_elastic_beanstalk_environment.app-env,
  ]
}

## Deploy the application in the EB environment ##

resource "null_resource" "deploy-application" {
  provisioner "local-exec" {
  command = "aws --region ${var.aws_region} elasticbeanstalk update-environment --environment-name ${aws_elastic_beanstalk_environment.app-env.name} --version-label ${aws_elastic_beanstalk_application_version.app-code.name} --output text"
  }
  depends_on = [
    null_resource.sleep,
  ]
}
